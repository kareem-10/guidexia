import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';
import 'package:tourist_app/features/guides/data/repos/guides_repo.dart';
import 'package:tourist_app/features/guides/view_model/guide_cubit/guides_state.dart';

class GuidesCubit extends Cubit<GuidesState> {
  final GuidesRepo repo;

  GuidesCubit(this.repo) : super(const GuidesInitial());

  final Set<int> _favoriteIds = {};

  Future<void> loadGuides() async {
    emit(const GuidesLoading());

    final result = await repo.getGuides();

    result.fold(
      (failure) {
        emit(GuidesFailure(failure.message));
      },
      (guides) {
        emit(
          GuidesSuccess(
            List.unmodifiable(guides),
            Set.unmodifiable(_favoriteIds),
          ),
        );
      },
    );
  }

  void toggleFavorite(int guideId) {
    if (!_favoriteIds.add(guideId)) {
      _favoriteIds.remove(guideId);
    }

    final currentState = state;

    if (currentState is GuidesSuccess) {
      emit(GuidesSuccess(currentState.guides, Set.unmodifiable(_favoriteIds)));
    }
  }

  bool isFavorite(int guideId) => _favoriteIds.contains(guideId);

  List<GuideModel> get favoriteGuides {
    final currentState = state;

    if (currentState is! GuidesSuccess) return [];

    return currentState.guides
        .where((guide) => _favoriteIds.contains(guide.id))
        .toList();
  }
}
