import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';

import '../models/profile_model.dart';

class ProfileRepository {
  final ApiConsumer _apiConsumer;

  ProfileRepository(this._apiConsumer);

  Future<ProfileModel> getProfile() async {
    final response = await _apiConsumer.get(EndPoints.getUserData);

    final profileJson = response is Map && response['data'] is Map
        ? Map<String, dynamic>.from(response['data'])
        : Map<String, dynamic>.from(response);

    return ProfileModel.fromJson(profileJson);
  }

  Future<ProfileModel> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? bio,
    String? location,
  }) async {
    final Map<String, dynamic> data = {};

    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;
    if (bio != null) data['bio'] = bio;
    if (location != null) data['location'] = location;

    final response = await _apiConsumer.put(EndPoints.getUserData, data: data);

    final profileJson = response is Map && response['data'] is Map
        ? Map<String, dynamic>.from(response['data'])
        : Map<String, dynamic>.from(response);

    return ProfileModel.fromJson(profileJson);
  }

  // Mock data temporarily
  Future<List<TripModel>> getTrips({required bool upcoming}) async {
    final response = await _apiConsumer.get(
      EndPoints.trips,
      queryParameters: {'upcoming': upcoming},
    );

    final List<dynamic> tripsJson = response is List
        ? response
        : response['data'] ?? [];

    return tripsJson.map((trip) => TripModel.fromJson(trip)).toList();
  }
}
