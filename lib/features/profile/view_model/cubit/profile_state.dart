import '../../data/models/profile_model.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState {
  final ProfileStatus status;
  final ProfileModel? profile;
  final List<TripModel> trips;
  final List<ReviewModel> reviews;
  final bool tripNotifications;
  final bool reviewNotifications;
  final bool appNotifications;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.trips = const [],
    this.reviews = const [],
    this.tripNotifications = true,
    this.reviewNotifications = true,
    this.appNotifications = true,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileModel? profile,
    List<TripModel>? trips,
    List<ReviewModel>? reviews,
    bool? tripNotifications,
    bool? reviewNotifications,
    bool? appNotifications,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      trips: trips ?? this.trips,
      reviews: reviews ?? this.reviews,
      tripNotifications: tripNotifications ?? this.tripNotifications,
      reviewNotifications: reviewNotifications ?? this.reviewNotifications,
      appNotifications: appNotifications ?? this.appNotifications,
      errorMessage: errorMessage,
    );
  }
}
