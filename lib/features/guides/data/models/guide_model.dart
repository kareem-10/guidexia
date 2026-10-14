class GuideModel {
  final int id;
  final String userId;
  final String name; // Temporary field: ask backend to add it.
  final String bio; // Temporary field: ask backend to add it.
  final String location;
  final String languages;
  final String specialties;
  final bool isVerified;
  final int experienceYears;
  final int happyTravelers;
  final double averageRating;
  final int reviewCount;
  final double pricePerPerson;
  final String? profileImageUrl;
  final String? coverImageUrl;

  const GuideModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.bio,
    required this.location,
    required this.languages,
    required this.specialties,
    required this.isVerified,
    required this.experienceYears,
    required this.happyTravelers,
    required this.averageRating,
    required this.reviewCount,
    required this.pricePerPerson,
    this.profileImageUrl,
    this.coverImageUrl,
  });

  factory GuideModel.fromJson(Map<String, dynamic> json) {
    double asDouble(dynamic value) => value is num ? value.toDouble() : double.tryParse('$value') ?? 0;
    int asInt(dynamic value) => value is num ? value.toInt() : int.tryParse('$value') ?? 0;
    return GuideModel(
      id: asInt(json['id']),
      userId: json['userId']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Guide #${json['id'] ?? ''}',
      bio: json['bio']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      languages: json['languages']?.toString() ?? '',
      specialties: json['specialties']?.toString() ?? '',
      isVerified: json['isVerified'] == true,
      experienceYears: asInt(json['experienceYears']),
      happyTravelers: asInt(json['happyTravelers']),
      averageRating: asDouble(json['averageRating']),
      reviewCount: asInt(json['reviewCount']),
      pricePerPerson: asDouble(json['pricePerPerson']),
      profileImageUrl: json['profileImageUrl']?.toString(),
      coverImageUrl: json['coverImageUrl']?.toString(),
    );
  }
}
