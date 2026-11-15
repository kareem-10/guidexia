import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/place_details/data/repos/place_details_repo.dart';
import 'package:tourist_app/features/place_details/view_model/cubit/place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  final PlaceDetailsRepo placeDetailsRepo;

  PlaceDetailsCubit(this.placeDetailsRepo) : super(const PlaceDetailsInitial());

  Future<void> getActivities(int placeId) async {
    emit(const ActivitiesLoading());

    final result = await placeDetailsRepo.getActivities(placeId);

    result.fold(
      (failure) {
        emit(ActivitiesFailure(failure.message));
      },
      (activities) {
        emit(ActivitiesSuccess(activities));
      },
    );
  }
}
