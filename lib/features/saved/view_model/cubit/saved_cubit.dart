import 'package:flutter_bloc/flutter_bloc.dart';

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
      final results = await Future.wait([
        savedRepository.getSaves(),
        exploreRepo.getPlaces(),
        guidesRepo.getGuides(),
        stayRepository.getStays(),
      ]);

      final saves = (results[0] as List).cast<SavedModel>();

      _allPlaces = (results[1] as List).cast<PlaceModel>();
      _allGuides = (results[2] as List).cast<GuideModel>();
      _allStays = (results[3] as List).cast<StayModel>();

      _emitSuccess(saves);
    } catch (e) {
      emit(SavedFailure(e.toString()));
    }
  }

  bool _isSaved(List<SavedModel> saves, String entityType, int entityId) {
    return saves.any(
      (save) =>
          save.entityType.toLowerCase() == entityType.toLowerCase() &&
          save.entityId == entityId,
    );
  }

  void _emitSuccess(List<SavedModel> saves) {
    emit(
      SavedSuccess(
        saves: List<SavedModel>.unmodifiable(saves),
        places: _allPlaces
            .where((item) => _isSaved(saves, 'Place', item.id))
            .toList(),
        guides: _allGuides
            .where((item) => _isSaved(saves, 'Guide', item.id))
            .toList(),
        stays: _allStays
            .where((item) => _isSaved(saves, 'Stay', item.id))
            .toList(),
      ),
    );
  }

  Future<void> toggleSave({required String entityType, required int entityId}) {
    return _toggleSave(entityType: entityType, entityId: entityId);
  }

  Future<void> togglePlaceSave(int id) =>
      _toggleSave(entityType: 'Place', entityId: id);

  Future<void> toggleGuideSave(int id) =>
      _toggleSave(entityType: 'Guide', entityId: id);

  Future<void> toggleStaySave(int id) =>
      _toggleSave(entityType: 'Stay', entityId: id);

  Future<void> _toggleSave({
    required String entityType,
    required int entityId,
  }) async {
    final normalizedType = entityType.toLowerCase();
    final key = '${normalizedType}_$entityId';

    if (togglingItems.contains(key)) return;

    final current = state;
    if (current is! SavedSuccess) return;

    togglingItems.add(key);

    final wasSaved = _isSaved(current.saves, entityType, entityId);

    final updatedSaves = List<SavedModel>.from(current.saves);

    if (wasSaved) {
      updatedSaves.removeWhere(
        (save) =>
            save.entityType.toLowerCase() == normalizedType &&
            save.entityId == entityId,
      );
    } else {
      updatedSaves.add(
        SavedModel(
          id: -DateTime.now().microsecondsSinceEpoch,
          entityType: entityType,
          entityId: entityId,
          savedAt: DateTime.now(),
        ),
      );
    }

    // تحديث القلب وصفحة Saved فورًا.
    _emitSuccess(updatedSaves);

    try {
      await savedRepository.toggleSaves(
        entityType: entityType,
        entityId: entityId,
      );

      // مزامنة الحفظ مع الريبو بدون إعادة تحميل كل البيانات.
      final confirmedSaves = await savedRepository.getSaves();
      _emitSuccess(confirmedSaves.cast<SavedModel>());
    } catch (_) {
      // استرجاع حالة العنصر الحالي فقط،
      // مع الحفاظ على تغييرات العناصر الأخرى.
      final latest = state;

      if (latest is SavedSuccess) {
        final rollbackSaves = List<SavedModel>.from(latest.saves);

        rollbackSaves.removeWhere(
          (save) =>
              save.entityType.toLowerCase() == normalizedType &&
              save.entityId == entityId,
        );

        if (wasSaved) {
          final previousSave = current.saves.where(
            (save) =>
                save.entityType.toLowerCase() == normalizedType &&
                save.entityId == entityId,
          );

          rollbackSaves.addAll(previousSave);
        }

        _emitSuccess(rollbackSaves);
      }
    } finally {
      togglingItems.remove(key);

      // إجبار الواجهة على إعادة البناء بعد انتهاء العملية.
      final latest = state;
      if (latest is SavedSuccess) {
        _emitSuccess(latest.saves);
      }
    }
  }

  Future<bool> isSave(int placeId) {
    return savedRepository.checkSave(entityType: 'Place', entityId: placeId);
  }
}
