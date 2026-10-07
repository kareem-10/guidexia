import 'package:tourist_app/core/api/end_ponits.dart';

class ProfileModel {
  final String profilePic;
  final String email;
  final String phone;
  final String name;
  final Map<String, dynamic> address;

  ProfileModel({
    required this.profilePic,
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return ProfileModel(
      profilePic: jsonData['user'][ApiKey.profilePic],
      email: jsonData['user'][ApiKey.email],
      phone: jsonData['user'][ApiKey.phone],
      name: jsonData['user'][ApiKey.name],
      address: jsonData['user'][ApiKey.location],
    );
  }
}
