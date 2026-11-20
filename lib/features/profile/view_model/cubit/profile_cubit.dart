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
  final ProfileRepository _repository;
  final SecureStorageHelper _secureStorage;
  final CacheHelper _cacheHelper;

  final ImagePicker _imagePicker = ImagePicker();

  static const String _profileImageKey = 'profile_local_image';

  ProfileCubit(this._repository, this._secureStorage, this._cacheHelper)
    : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final results = await Future.wait([
        _repository.getProfile(),
        _repository.getTrips(),
        _repository.getReviews(),
      ]);

      ProfileModel profile = results[0] as ProfileModel;

      // Restore locally saved profile image.
      final savedImagePath = _cacheHelper.getDataString(key: _profileImageKey);

      if (savedImagePath != null && await File(savedImagePath).exists()) {
        profile = profile.copyWith(localImagePath: savedImagePath);
      } else {
        await _cacheHelper.removeData(key: _profileImageKey);
      }

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
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
      final updatedProfile = await _repository.updateProfile(
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
