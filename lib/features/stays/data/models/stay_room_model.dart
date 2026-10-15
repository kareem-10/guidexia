import 'package:equatable/equatable.dart';

class StayRoomModel extends Equatable {
  final int id;
  final String roomNumber;
  final String roomType;
  final String description;
  final double pricePerNight;
  final int maxOccupancy;
  final int bedCount;
  final bool isAvailable;
  final String imageUrl;

  const StayRoomModel({
    required this.id,
    required this.roomNumber,
    required this.roomType,
    required this.description,
    required this.pricePerNight,
    required this.maxOccupancy,
    required this.bedCount,
    required this.isAvailable,
    required this.imageUrl,
  });

  factory StayRoomModel.fromJson(Map<String, dynamic> json) {
    return StayRoomModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      roomNumber: json['roomNumber'] as String? ?? '',
      roomType: json['roomType'] as String? ?? '',
      description: json['description'] as String? ?? '',
      pricePerNight: (json['pricePerNight'] as num?)?.toDouble() ?? 0,
      maxOccupancy: (json['maxOccupancy'] as num?)?.toInt() ?? 0,
      bedCount: (json['bedCount'] as num?)?.toInt() ?? 0,
      isAvailable: json['isAvailable'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'roomNumber': roomNumber,
    'roomType': roomType,
    'description': description,
    'pricePerNight': pricePerNight,
    'maxOccupancy': maxOccupancy,
    'bedCount': bedCount,
    'isAvailable': isAvailable,
    'imageUrl': imageUrl,
  };

  @override
  List<Object?> get props => [
    id,
    roomNumber,
    roomType,
    description,
    pricePerNight,
    maxOccupancy,
    bedCount,
    isAvailable,
    imageUrl,
  ];
}
