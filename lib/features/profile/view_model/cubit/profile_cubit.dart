import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist_app/core/helpers/secure_storage_helper.dart';
import '../../data/models/profile_model.dart';
import '../../data/repos/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;
  final SecureStorageHelper _secureStorage;

  final ImagePicker _imagePicker = ImagePicker();

  ProfileCubit(this._profileRepository, this._secureStorage)
    : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final results = await Future.wait([
        _profileRepository.getProfile(),
        _profileRepository.getTrips(upcoming: true),
        _profileRepository.getTrips(upcoming: false),
      ]);

      final profile = results[0] as ProfileModel;
      final upcomingTrips = results[1] as List<TripModel>;
      final pastTrips = results[2] as List<TripModel>;

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          upcomingTrips: upcomingTrips,
          pastTrips: pastTrips,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<bool> pickProfileImage() async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedImage == null) return false;

      final updatedProfile = await _profileRepository.updateProfileImage(
        pickedImage.path,
      );

      emit(
        state.copyWith(profile: updatedProfile, status: ProfileStatus.success),
      );

      return true;
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Could not upload profile image.'));

      return false;
    }
  }

  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? bio,
    String? location,
  }) async {
    try {
      final updatedProfile = await _profileRepository.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        bio: bio,
        location: location,
      );

      emit(
        state.copyWith(profile: updatedProfile, status: ProfileStatus.success),
      );

      return true;
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'Could not update profile.',
        ),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _secureStorage.deleteToken();
  }

  void toggleTripNotifications(bool value) =>
      emit(state.copyWith(tripNotifications: value));

  void toggleReviewNotifications(bool value) =>
      emit(state.copyWith(reviewNotifications: value));

  void toggleAppNotifications(bool value) =>
      emit(state.copyWith(appNotifications: value));
}
