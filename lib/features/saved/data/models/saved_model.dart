class SavedModel {
  final int id;
  final String entityType;
  final int entityId;
  final DateTime? savedAt;

  const SavedModel({
    required this.id,
    required this.entityType,
    required this.entityId,
    this.savedAt,
  });

  factory SavedModel.fromJson(Map<String, dynamic> json) {
    return SavedModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      entityType: json['entityType']?.toString() ?? '',
      entityId: (json['entityId'] as num?)?.toInt() ?? 0,
      savedAt: DateTime.tryParse(
        (json['savedAt'] ?? json['saveAt'] ?? '').toString(),
      ),
    );
  }
}
