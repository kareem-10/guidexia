import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String city;
  final String country;
  final String category;
  final double entryFee;
  final String imageUrl;
  final String thumbnailUrl;
  final List<String> tags;
  final double averageRating;
  final int reviewCount;
  final bool isFeatured;
  final double? latitude;
  final double? longitude;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.country,
    required this.category,
    required this.entryFee,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.tags,
    required this.averageRating,
    required this.reviewCount,
    required this.isFeatured,
    this.latitude,
    this.longitude,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      entryFee: (json['entryFee'] as num?)?.toDouble() ?? 0,
      imageUrl: json['imageUrl']?.toString() ?? '',
      thumbnailUrl: json['thumbnailUrl']?.toString() ?? '',
      tags: json['tags'] is List
          ? List<String>.from((json['tags'] as List).map((e) => e.toString()))
          : [],
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      isFeatured: json['isFeatured'] == true,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'country': country,
      'category': category,
      'entryFee': entryFee,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
      'tags': tags,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'isFeatured': isFeatured,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    city,
    country,
    category,
    entryFee,
    imageUrl,
    thumbnailUrl,
    tags,
    averageRating,
    reviewCount,
    isFeatured,
    latitude,
    longitude,
  ];
}
