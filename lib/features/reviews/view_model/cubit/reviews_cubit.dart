import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tourist_app/features/reviews/data/repos/reviews_repo.dart';
import 'package:tourist_app/features/reviews/view_model/cubit/reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsRepo reviewsRepo;

  ReviewsCubit(this.reviewsRepo) : super(const ReviewsState());

  Future<void> loadReviews({
    required String referenceType,
    required int referenceId,
  }) async {
    emit(state.copyWith(status: ReviewsStatus.loading, clearError: true));

    final result = await reviewsRepo.getReviews(
      referenceType: referenceType,
      referenceId: referenceId,
    );

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ReviewsStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (reviews) {
        emit(
          state.copyWith(
            status: ReviewsStatus.success,
            reviews: List.unmodifiable(reviews),
            clearError: true,
          ),
        );
      },
    );
  }

  Future<bool> addReview({
    required String referenceType,
    required int referenceId,
    required int rating,
    required String comment,
  }) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));

    final result = await reviewsRepo.addReview(
      referenceType: referenceType,
      referenceId: referenceId,
      rating: rating,
      comment: comment,
    );

    if (isClosed) return false;

    return result.fold(
      (failure) {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.message),
        );
        return false;
      },
      (_) async {
        emit(state.copyWith(isSubmitting: false));

        await loadReviews(
          referenceType: referenceType,
          referenceId: referenceId,
        );

        return true;
      },
    );
  }

  Future<bool> deleteReview({
    required int reviewId,
    required String referenceType,
    required int referenceId,
  }) async {
    emit(state.copyWith(isDeleting: true, clearError: true));

    final result = await reviewsRepo.deleteReview(reviewId);

    if (isClosed) return false;

    return result.fold(
      (failure) {
        emit(state.copyWith(isDeleting: false, errorMessage: failure.message));
        return false;
      },
      (_) async {
        emit(state.copyWith(isDeleting: false));

        await loadReviews(
          referenceType: referenceType,
          referenceId: referenceId,
        );

        return true;
      },
    );
  }
}
