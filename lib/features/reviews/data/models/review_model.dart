class ReviewModel {
  final int id;
  final String referenceType;
  final int referenceId;
  final double rating;
  final String comment;
  final DateTime? reviewDate;
  final String reviewerName;

  const ReviewModel({
    required this.id,
    required this.referenceType,
    required this.referenceId,
    required this.rating,
    required this.comment,
    this.reviewDate,
    required this.reviewerName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    int asInt(dynamic value) {
      if (value is num) return value.toInt();
      return int.tryParse(value?.toString() ?? '') ?? 0;
    }

    double asDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    return ReviewModel(
      id: asInt(json['id']),
      referenceType: json['referenceType']?.toString() ?? '',
      referenceId: asInt(json['referenceId']),
      rating: asDouble(json['rating']),
      comment: json['comment']?.toString() ?? '',
      reviewDate: json['reviewDate'] == null
          ? null
          : DateTime.tryParse(json['reviewDate'].toString()),
      reviewerName: json['reviewerName']?.toString() ?? '',
    );
  }
}
