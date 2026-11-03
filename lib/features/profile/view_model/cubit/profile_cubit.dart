import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/profile_model.dart';
import '../../data/repos/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final results = await Future.wait([
        _repository.getProfile(),
        _repository.getTrips(),
        _repository.getReviews(),
      ]);
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: results[0] as ProfileModel,
          trips: results[1] as List<TripModel>,
          reviews: results[2] as List<ReviewModel>,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'Could not load profile data.',
        ),
      );
    }
  }

  void updateProfile(ProfileModel profile) {
    emit(state.copyWith(profile: profile, status: ProfileStatus.success));
  }

  void toggleTripNotifications(bool value) =>
      emit(state.copyWith(tripNotifications: value));

  void toggleReviewNotifications(bool value) =>
      emit(state.copyWith(reviewNotifications: value));

  void toggleAppNotifications(bool value) =>
      emit(state.copyWith(appNotifications: value));

  // UI state only for now. Connect this to your app-wide ThemeMode later.
  void toggleTheme(bool isDark) => emit(state.copyWith(isDarkMode: isDark));
}
