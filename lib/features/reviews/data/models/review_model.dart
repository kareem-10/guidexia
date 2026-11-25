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
    return ReviewModel(
      id: json['id'] as int,
      referenceType: json['referenceType'] ?? '',
      referenceId: json['referenceId'] as int,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] ?? '',
      reviewDate: json['reviewDate'] != null
          ? DateTime.tryParse(json['reviewDate'])
          : null,
      reviewerName: json['reviewerName'] ?? '',
    );
  }
}
