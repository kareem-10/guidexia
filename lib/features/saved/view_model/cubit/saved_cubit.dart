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
import 'package:tourist_app/features/saved/view_model/helpers/saved_helper.dart';
import 'package:tourist_app/features/saved/view_model/managers/saved_data_loader.dart';
import 'package:tourist_app/features/saved/view_model/managers/saved_toggle_manager.dart';

class SavedCubit extends Cubit<SavedState> {
  final SavedRepository savedRepository;

  late final SavedDataLoader _dataLoader;
  late final SavedToggleManager _toggleManager;

  final List<PlaceModel> _allPlaces = [];
  final List<GuideModel> _allGuides = [];
  final List<StayModel> _allStays = [];

  Set<String> get togglingItems => _toggleManager.togglingItems;

  SavedCubit(
    this.savedRepository,
    ExploreRepo exploreRepo,
    GuidesRepo guidesRepo,
    StayRepository stayRepository,
  ) : super(const SavedInitial()) {
    _dataLoader = SavedDataLoader(
      savedRepository: savedRepository,
      exploreRepo: exploreRepo,
      guidesRepo: guidesRepo,
      stayRepository: stayRepository,
    );

    _toggleManager = SavedToggleManager(savedRepository);
  }

  Future<void> getSaves() async {
    emit(const SavedLoading());

    try {
      final data = await _dataLoader.load();

      _allPlaces
        ..clear()
        ..addAll(data.places);

      _allGuides
        ..clear()
        ..addAll(data.guides);

      _allStays
        ..clear()
        ..addAll(data.stays);

      _emitSuccess(data.saves);
    } catch (e) {
      emit(SavedFailure(e.toString()));
    }
  }

  void _emitSuccess(List<SavedModel> saves) {
    emit(
      SavedHelper.buildSuccess(
        saves: saves,
        allPlaces: _allPlaces,
        allGuides: _allGuides,
        allStays: _allStays,
      ),
    );
  }

  List<SavedModel> _getCurrentSaves() {
    final current = state;

    if (current is SavedSuccess) {
      return current.saves;
    }

    return [];
  }

  Future<void> toggleSave({
    required String entityType,
    required int entityId,
  }) async {
    if (state is! SavedSuccess) return;

    await _toggleManager.toggle(
      entityType: entityType,
      entityId: entityId,
      getCurrentSaves: _getCurrentSaves,
      onUpdate: _emitSuccess,
    );
  }

  Future<void> togglePlaceSave(int id) {
    return toggleSave(entityType: 'Place', entityId: id);
  }

  Future<void> toggleGuideSave(int id) {
    return toggleSave(entityType: 'Guide', entityId: id);
  }

  Future<void> toggleStaySave(int id) {
    return toggleSave(entityType: 'Accommodation', entityId: id);
  }

  Future<bool> isSave(int placeId) async {
    final result = await savedRepository.checkSave(
      entityType: 'Place',
      entityId: placeId,
    );

    return result.fold((failure) => false, (isSaved) => isSaved);
  }
}
