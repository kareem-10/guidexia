import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/guide_model.dart';
import '../../data/repos/guides_repo.dart';
import 'guides_state.dart';

class GuidesCubit extends Cubit<GuidesState> {
  final GuidesRepo repo;
  GuidesCubit(this.repo) : super(const GuidesInitial());

  List<GuideModel> _guides = [];
  final Set<int> _favoriteIds = <int>{};

  Future<void> loadGuides() async {
    emit(const GuidesLoading());
    try {
      _guides = await repo.getGuides();
      emit(GuidesSuccess(List.unmodifiable(_guides), Set.unmodifiable(_favoriteIds)));
    } catch (_) {
      emit(const GuidesFailure('Could not load guides. Please try again.'));
    }
  }

  void toggleFavorite(int guideId) {
    if (!_favoriteIds.add(guideId)) _favoriteIds.remove(guideId);
    emit(GuidesSuccess(List.unmodifiable(_guides), Set.unmodifiable(_favoriteIds)));
  }

  bool isFavorite(int guideId) => _favoriteIds.contains(guideId);
  List<GuideModel> get favoriteGuides => _guides.where((g) => _favoriteIds.contains(g.id)).toList();
}
