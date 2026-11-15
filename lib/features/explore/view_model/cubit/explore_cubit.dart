import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';
import 'package:tourist_app/features/explore/data/repos/explore_repo.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepo exploreRepo;

  ExploreCubit(this.exploreRepo) : super(const ExploreInitial());

  List<PlaceModel> _allPlaces = [];
  String selectedCategory = 'All';
  String searchQuery = '';

  bool _isPlacesLoaded = false;

  Future<void> getPlaces() async {
    emit(const ExploreLoading());

    final result = await exploreRepo.getPlaces();

    result.fold((failure) => emit(ExploreFailure(message: failure.message)), (
      places,
    ) {
      _allPlaces = places;
      _isPlacesLoaded = true;
      _applyFilters();
    });
  }

  void selectCategory(String category) {
    selectedCategory = category;
    _applyFilters();
  }

  void searchPlaces(String value) {
    searchQuery = value;
    _applyFilters();
  }

  void _applyFilters() {
    var filteredPlaces = _allPlaces;

    if (!_isPlacesLoaded) return;

    if (selectedCategory != 'All') {
      filteredPlaces = filteredPlaces
          .where(
            (place) =>
                place.category.toLowerCase() == selectedCategory.toLowerCase(),
          )
          .toList();
    }

    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();

      filteredPlaces = filteredPlaces.where((place) {
        return place.name.toLowerCase().contains(query) ||
            place.city.toLowerCase().contains(query) ||
            place.country.toLowerCase().contains(query);
      }).toList();
    }

    emit(
      ExploreSuccess(
        places: filteredPlaces,
        selectedCategory: selectedCategory,
        searchQuery: searchQuery,
      ),
    );
  }
}
