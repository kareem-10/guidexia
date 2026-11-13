class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final String country;
  final String city;
  final String role;
  final String? imageUrl;

  const ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    required this.role,
    this.imageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final touristProfile = Map<String, dynamic>.from(
      json['touristProfile'] ?? {},
    );

    final guideProfile = Map<String, dynamic>.from(json['guideProfile'] ?? {});

    final firstName = json['firstName']?.toString() ?? '';
    final lastName = json['lastName']?.toString() ?? '';

    final fullName = json['fullName']?.toString().trim();

    final name = (fullName != null && fullName.isNotEmpty)
        ? fullName
        : '$firstName $lastName'.trim();

    return ProfileModel(
      name: name,
      email: json['email']?.toString() ?? '',
      phone: json['phoneNumber']?.toString() ?? '',
      country: touristProfile['nationality']?.toString() ?? '',
      city:
          touristProfile['displayLocation']?.toString() ??
          guideProfile['location']?.toString() ??
          '',
      role: json['role']?.toString() ?? '',
      imageUrl:
          json['profileImageUrl']?.toString() ??
          guideProfile['profileImageUrl']?.toString(),
    );
  }

  ProfileModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? country,
    String? city,
    String? role,
    String? imageUrl,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
      city: city ?? this.city,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class TripModel {
  final String title;
  final String location;
  final String date;
  final String status;
  final String imageUrl;

  const TripModel({
    required this.title,
    required this.location,
    required this.date,
    required this.status,
    required this.imageUrl,
  });
}

class ReviewModel {
  final String placeName;
  final String comment;
  final double rating;
  final String date;
  final String imageUrl;

  const ReviewModel({
    required this.placeName,
    required this.comment,
    required this.rating,
    required this.date,
    required this.imageUrl,
  });
}
