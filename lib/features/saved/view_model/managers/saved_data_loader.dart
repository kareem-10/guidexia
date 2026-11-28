import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/explore/data/repos/explore_repo.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';
import 'package:tourist_app/features/guides/data/repos/guides_repo.dart';
import 'package:tourist_app/features/stays/data/models/stay_model.dart';
import 'package:tourist_app/features/stays/data/repos/stay_repository.dart';
import 'package:tourist_app/features/saved/data/models/saved_model.dart';
import 'package:tourist_app/features/saved/data/repos/saved_repo.dart';

class SavedData {
  final List<SavedModel> saves;
  final List<PlaceModel> places;
  final List<GuideModel> guides;
  final List<StayModel> stays;

  const SavedData({
    required this.saves,
    required this.places,
    required this.guides,
    required this.stays,
  });
}

class SavedDataLoader {
  final SavedRepository savedRepository;
  final ExploreRepo exploreRepo;
  final GuidesRepo guidesRepo;
  final StayRepository stayRepository;

  SavedDataLoader({
    required this.savedRepository,
    required this.exploreRepo,
    required this.guidesRepo,
    required this.stayRepository,
  });

  Future<SavedData> load() async {
    final savesResult = await savedRepository.getSaves();

    final saves = savesResult.fold(
      (failure) => throw Exception(failure.toString()),
      (data) => data,
    );

    final places = await _getAllPlaces();

    final guidesResult = await guidesRepo.getGuides();

    final guides = guidesResult.fold(
      (failure) => throw Exception(failure.toString()),
      (data) => data,
    );

    final stays = await stayRepository.getStays();

    return SavedData(
      saves: saves,
      places: places,
      guides: guides,
      stays: stays,
    );
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
}
