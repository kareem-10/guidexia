import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tourist_app/core/helpers/cache_helper.dart';
import 'package:tourist_app/core/helpers/secure_storage_helper.dart';
import '../../data/models/profile_model.dart';
import '../../data/repos/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;
  final SecureStorageHelper _secureStorage;
  final CacheHelper _cacheHelper;

  final ImagePicker _imagePicker = ImagePicker();

  static const String _profileImageKey = 'profile_local_image';

  ProfileCubit(this._profileRepository, this._secureStorage, this._cacheHelper)
    : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final results = await Future.wait([
        _profileRepository.getProfile(),
        _profileRepository.getTrips(upcoming: true),
        _profileRepository.getTrips(upcoming: false),
        _profileRepository.getReviews(),
      ]);

      final profile = results[0] as ProfileModel;
      final upcomingTrips = results[1] as List<TripModel>;
      final pastTrips = results[2] as List<TripModel>;
      final reviews = results[3] as List<MyReviewModel>;

      final localImagePath = _cacheHelper.getDataString(
        key: 'profile_local_image',
      );

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile.copyWith(localImagePath: localImagePath),
          upcomingTrips: upcomingTrips,
          pastTrips: pastTrips,
          reviews: reviews,
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

      final appDirectory = await getApplicationDocumentsDirectory();

      final extension = pickedImage.path.split('.').last;
      final fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}.$extension';

      final savedImage = await File(
        pickedImage.path,
      ).copy('${appDirectory.path}/$fileName');

      await _cacheHelper.saveData(
        key: _profileImageKey,
        value: savedImage.path,
      );

      final currentProfile = state.profile;

      if (currentProfile != null) {
        emit(
          state.copyWith(
            profile: currentProfile.copyWith(localImagePath: savedImage.path),
          ),
        );
      }

      return true;
    } catch (e) {
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

      // Preserve the local image after updating profile data.
      final localImagePath = _cacheHelper.getDataString(key: _profileImageKey);

      final profileWithLocalImage =
          localImagePath != null && await File(localImagePath).exists()
          ? updatedProfile.copyWith(localImagePath: localImagePath)
          : updatedProfile;

      emit(
        state.copyWith(
          profile: profileWithLocalImage,
          status: ProfileStatus.success,
        ),
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
