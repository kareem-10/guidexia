import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/guides/data/repos/guides_repo.dart';
import 'package:tourist_app/features/guides/view_model/guide_details_cubit/guide_details_state.dart';

class GuideDetailsCubit extends Cubit<GuideDetailsState> {
  final GuidesRepo repo;

  GuideDetailsCubit(this.repo) : super(const GuideDetailsInitial());

  Future<void> loadGuideDetails(int guideId) async {
    emit(const GuideDetailsLoading());

    final result = await repo.getGuideDetails(guideId);

    result.fold(
      (failure) {
        emit(GuideDetailsFailure(failure.message));
      },
      (guide) {
        emit(GuideDetailsSuccess(guide));
      },
    );
  }
}
