import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/explore/data/repos/explore_repo.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';
import 'package:tourist_app/features/guides/data/repos/guides_repo.dart';
import 'package:tourist_app/features/stays/data/models/stay_model.dart';
import 'package:tourist_app/features/stays/data/repos/stay_repository.dart';
import 'package:tourist_app/features/saved/data/models/saved_model.dart';
import 'package:tourist_app/features/saved/data/repos/saved_repo.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  final SavedRepository savedRepository;
  final ExploreRepo exploreRepo;
  final GuidesRepo guidesRepo;
  final StayRepository stayRepository;

  final Set<String> togglingItems = {};

  List<PlaceModel> _allPlaces = [];
  List<GuideModel> _allGuides = [];
  List<StayModel> _allStays = [];

  SavedCubit(
    this.savedRepository,
    this.exploreRepo,
    this.guidesRepo,
    this.stayRepository,
  ) : super(const SavedInitial());

  Future<void> getSaves() async {
    emit(const SavedLoading());

    try {
      final savesResult = await savedRepository.getSaves();

      final saves = savesResult.fold(
        (failure) => throw Exception(failure.toString()),
        (data) => data,
      );

      _allPlaces = await _getAllPlaces();

      final guidesResult = await guidesRepo.getGuides();

      _allGuides = guidesResult.fold(
        (failure) => throw Exception(failure.toString()),
        (data) => data,
      );

      _allStays = await stayRepository.getStays();

      _emitSuccess(saves);
    } catch (e) {
      emit(SavedFailure(e.toString()));
    }
  }

  Future<List<PlaceModel>> _getAllPlaces() async {
    const pageSize = 50;
    var pageIndex = 1;

    final firstResult = await exploreRepo.getPlaces(
      pageIndex: pageIndex,
      pageSize: pageSize,
    );

    final firstPage = firstResult.fold(
      (failure) => throw Exception(failure.toString()),
      (data) => data,
    );

    final places = List<PlaceModel>.from(firstPage.data);

    for (pageIndex = 2; pageIndex <= firstPage.totalPages; pageIndex++) {
      final result = await exploreRepo.getPlaces(
        pageIndex: pageIndex,
        pageSize: pageSize,
      );

      final page = result.fold(
        (failure) => throw Exception(failure.toString()),
        (data) => data,
      );

      places.addAll(page.data);
    }

    return places;
  }

  String _normalizeType(String entityType) {
    switch (entityType.toLowerCase()) {
      case 'place':
        return 'Place';
      case 'guide':
        return 'Guide';
      case 'stay':
      case 'accommodation':
        return 'Accommodation';
      default:
        return entityType;
    }
  }

  bool _isSaved(List<SavedModel> saves, String entityType, int entityId) {
    final normalizedType = _normalizeType(entityType);

    return saves.any(
      (save) =>
          _normalizeType(save.entityType) == normalizedType &&
          save.entityId == entityId,
    );
  }

  void _emitSuccess(List<SavedModel> saves) {
    emit(
      SavedSuccess(
        saves: List.unmodifiable(saves),
        places: _allPlaces
            .where((item) => _isSaved(saves, 'Place', item.id))
            .toList(),
        guides: _allGuides
            .where((item) => _isSaved(saves, 'Guide', item.id))
            .toList(),
        stays: _allStays
            .where((item) => _isSaved(saves, 'Accommodation', item.id))
            .toList(),
      ),
    );
  }

  Future<void> toggleSave({required String entityType, required int entityId}) {
    return _toggleSave(entityType: entityType, entityId: entityId);
  }

  Future<void> togglePlaceSave(int id) {
    return _toggleSave(entityType: 'Place', entityId: id);
  }

  Future<void> toggleGuideSave(int id) {
    return _toggleSave(entityType: 'Guide', entityId: id);
  }

  Future<void> toggleStaySave(int id) {
    return _toggleSave(entityType: 'Accommodation', entityId: id);
  }

  Future<void> _toggleSave({
    required String entityType,
    required int entityId,
  }) async {
    final normalizedType = _normalizeType(entityType);
    final key = '${normalizedType.toLowerCase()}_$entityId';

    if (togglingItems.contains(key)) return;

    final current = state;
    if (current is! SavedSuccess) return;

    togglingItems.add(key);

    final wasSaved = _isSaved(current.saves, normalizedType, entityId);

    final updatedSaves = List<SavedModel>.from(current.saves);

    if (wasSaved) {
      updatedSaves.removeWhere(
        (save) =>
            _normalizeType(save.entityType) == normalizedType &&
            save.entityId == entityId,
      );
    } else {
      updatedSaves.add(
        SavedModel(
          id: -DateTime.now().microsecondsSinceEpoch,
          entityType: normalizedType,
          entityId: entityId,
          savedAt: DateTime.now(),
        ),
      );
    }

    _emitSuccess(updatedSaves);

    try {
      final toggleResult = await savedRepository.toggleSaves(
        entityType: normalizedType,
        entityId: entityId,
      );

      final toggleSucceeded = toggleResult.fold(
        (failure) => false,
        (data) => true,
      );

      if (!toggleSucceeded) {
        _rollbackSave(
          current: current,
          entityType: normalizedType,
          entityId: entityId,
          wasSaved: wasSaved,
        );
        return;
      }

      _emitSuccess(updatedSaves);
    } catch (_) {
      _rollbackSave(
        current: current,
        entityType: normalizedType,
        entityId: entityId,
        wasSaved: wasSaved,
      );
    } finally {
      togglingItems.remove(key);

      final latest = state;
      if (latest is SavedSuccess) {
        _emitSuccess(latest.saves);
      }
    }
  }

  void _rollbackSave({
    required SavedSuccess current,
    required String entityType,
    required int entityId,
    required bool wasSaved,
  }) {
    final latest = state;
    if (latest is! SavedSuccess) return;

    final rollbackSaves = List<SavedModel>.from(latest.saves);

    rollbackSaves.removeWhere(
      (save) =>
          _normalizeType(save.entityType) == entityType &&
          save.entityId == entityId,
    );

    if (wasSaved) {
      final previousSave = current.saves.where(
        (save) =>
            _normalizeType(save.entityType) == entityType &&
            save.entityId == entityId,
      );

      rollbackSaves.addAll(previousSave);
    }

    _emitSuccess(rollbackSaves);
  }

  Future<bool> isSave(int placeId) async {
    final result = await savedRepository.checkSave(
      entityType: 'Place',
      entityId: placeId,
    );

    return result.fold((failure) => false, (isSaved) => isSaved);
  }
}
