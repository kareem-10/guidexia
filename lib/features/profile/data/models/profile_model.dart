class ProfileModel {
  final String name;
  final String email;
  final String phone;
  final String? location;
  final String role;
  final String? imageUrl;
  final String? localImagePath;
  final String firstName;
  final String lastName;
  final String bio;

  const ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    this.location,
    required this.role,
    this.imageUrl,
    this.localImagePath,
    this.firstName = '',
    this.lastName = '',
    this.bio = '',
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
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      bio:
          json['touristProfile']?['bio']?.toString() ??
          json['guideProfile']?['bio']?.toString() ??
          '',
      email: json['email']?.toString() ?? '',
      phone: json['phoneNumber']?.toString() ?? '',
      location:
          touristProfile['displayLocation']?.toString() ??
          guideProfile['location']?.toString() ??
          json['location']?.toString() ??
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
    String? role,
    String? location,
    String? imageUrl,
    String? firstName,
    String? lastName,
    String? bio,
    String? localImagePath,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
    );
  }
}

class TripModel {
  final int id;
  final String title;
  final String location;
  final String date;
  final String endDate;
  final String status;
  final int travelerCount;
  final String imageUrl;
  final String estimatedBudgetPerPerson;
  final bool isAiGenerated;

  const TripModel({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.endDate,
    required this.status,
    required this.travelerCount,
    required this.imageUrl,
    required this.estimatedBudgetPerPerson,
    required this.isAiGenerated,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] ?? 0,
      title: json['name'] ?? '',
      location: json['destination'] ?? '',
      date: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      status: json['status'] ?? '',
      travelerCount: json['travelerCount'] ?? 0,
      imageUrl: json['coverImageUrl'] ?? '',
      estimatedBudgetPerPerson:
          json['estimatedBudgetPerPerson']?.toString() ?? '',
      isAiGenerated: json['isAiGenerated'] ?? false,
    );
  }
}

class MyReviewModel {
  final String placeName;
  final String comment;
  final double rating;
  final String date;
  final String imageUrl;

  const MyReviewModel({
    required this.placeName,
    required this.comment,
    required this.rating,
    required this.date,
    required this.imageUrl,
  });
}
