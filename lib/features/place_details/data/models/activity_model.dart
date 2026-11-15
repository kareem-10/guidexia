class ActivityModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int durationInMinutes;
  final String? badge;
  final int touristPlaceId;

  const ActivityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationInMinutes,
    this.badge,
    required this.touristPlaceId,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: (json['id'] as num).toInt(),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      durationInMinutes: (json['durationInMinutes'] as num?)?.toInt() ?? 0,
      badge: json['badge']?.toString(),
      touristPlaceId: (json['touristPlaceId'] as num).toInt(),
    );
  }
}
