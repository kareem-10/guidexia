import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/explore/data/repos/explore_repo.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepo exploreRepo;

  ExploreCubit(this.exploreRepo) : super(const ExploreInitial());

  String selectedCategory = 'All';

  Future<void> getPlaces({String? category, String? search}) async {
    emit(const ExploreLoading());

    try {
      final places = await exploreRepo.getPlaces(
        category: category,
        search: search,
      );

      emit(ExploreSuccess(places: places, selectedCategory: selectedCategory));
    } catch (e) {
      emit(ExploreFailure(message: e.toString()));
    }
  }

  void selectCategory(String category) {
    selectedCategory = category;

    getPlaces(category: category == 'All' ? null : category);
  }

  void searchPlaces(String value) {
    getPlaces(
      category: selectedCategory == 'All' ? null : selectedCategory,
      search: value,
    );
  }
}
