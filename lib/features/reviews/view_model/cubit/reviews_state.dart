import 'package:equatable/equatable.dart';
import 'package:tourist_app/features/reviews/data/models/review_model.dart';

enum ReviewsStatus { initial, loading, success, failure }

class ReviewsState extends Equatable {
  final ReviewsStatus status;
  final List<ReviewModel> reviews;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isDeleting;

  const ReviewsState({
    this.status = ReviewsStatus.initial,
    this.reviews = const [],
    this.isSubmitting = false,
    this.errorMessage,
    this.isDeleting = false,
  });

  ReviewsState copyWith({
    ReviewsStatus? status,
    List<ReviewModel>? reviews,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
    bool? isDeleting,
  }) {
    return ReviewsState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    reviews,
    isSubmitting,
    errorMessage,
    isDeleting,
  ];
}
