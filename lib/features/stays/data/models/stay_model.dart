import 'package:equatable/equatable.dart';
import 'stay_room_model.dart';

class StayModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String city;
  final String country;
  final String type;
  final int starRating;
  final double pricePerNight;
  final String currency;
  final double averageRating;
  final int reviewCount;
  final String imageUrl;
  final String thumbnailUrl;
  final String websiteUrl;
  final double latitude;
  final double longitude;
  final List<String> amenities;
  final List<StayRoomModel> rooms;

  const StayModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.country,
    required this.type,
    required this.starRating,
    required this.pricePerNight,
    required this.currency,
    required this.averageRating,
    required this.reviewCount,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.websiteUrl,
    required this.latitude,
    required this.longitude,
    required this.amenities,
    required this.rooms,
  });

  factory StayModel.fromJson(Map<String, dynamic> json) {
    return StayModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      city: json['city'] as String? ?? '',
      country: json['country'] as String? ?? '',
      type: json['type'] as String? ?? '',
      starRating: (json['starRating'] as num?)?.toInt() ?? 0,
      pricePerNight: (json['pricePerNight'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? '',
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      websiteUrl: json['websiteUrl'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      amenities:
          (json['amenities'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          const [],
      rooms:
          (json['rooms'] as List<dynamic>?)
              ?.map(
                (item) => StayRoomModel.fromJson(
                  Map<String, dynamic>.from(item as Map),
                ),
              )
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'city': city,
    'country': country,
    'type': type,
    'starRating': starRating,
    'pricePerNight': pricePerNight,
    'currency': currency,
    'averageRating': averageRating,
    'reviewCount': reviewCount,
    'imageUrl': imageUrl,
    'thumbnailUrl': thumbnailUrl,
    'websiteUrl': websiteUrl,
    'latitude': latitude,
    'longitude': longitude,
    'amenities': amenities,
    'rooms': rooms.map((room) => room.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    city,
    country,
    type,
    starRating,
    pricePerNight,
    currency,
    averageRating,
    reviewCount,
    imageUrl,
    thumbnailUrl,
    websiteUrl,
    latitude,
    longitude,
    amenities,
    rooms,
  ];
}
