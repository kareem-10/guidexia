part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;

  const ProfileSuccess({required this.profileModel});
  @override
  List<Object> get props => [profileModel];
}

final class ProfileError extends ProfileState {
  final String message;
  const ProfileError({required this.message});
  @override
  List<Object> get props => [message];
}

final class UploadProfilePic extends ProfileState {}
