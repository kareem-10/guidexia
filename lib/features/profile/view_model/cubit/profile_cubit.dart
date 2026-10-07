import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';
import 'package:tourist_app/features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final ProfileRepo profileRepo;

  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    final response = await profileRepo.getUserProfile();
    response.fold(
      (errMessage) => emit(ProfileError(message: errMessage)),
      (user) => emit(ProfileSuccess(profileModel: user)),
    );
  }
}
