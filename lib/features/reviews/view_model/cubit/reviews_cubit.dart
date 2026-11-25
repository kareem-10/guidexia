import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/error/exceptions.dart';
import 'package:tourist_app/features/reviews/data/repos/reviews_repo.dart';
import 'package:tourist_app/features/reviews/view_model/cubit/reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsRepo reviewsRepo;

  ReviewsCubit(this.reviewsRepo) : super(const ReviewsState());

  Future<void> loadReviews({
    required String referenceType,
    required int referenceId,
  }) async {
    emit(state.copyWith(status: ReviewsStatus.loading, errorMessage: null));

    try {
      final reviews = await reviewsRepo.getReviews(
        referenceType: referenceType,
        referenceId: referenceId,
      );

      emit(state.copyWith(status: ReviewsStatus.success, reviews: reviews));
    } catch (e) {
      emit(
        state.copyWith(
          status: ReviewsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<bool> addReview({
    required String referenceType,
    required int referenceId,
    required int rating,
    required String comment,
  }) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await reviewsRepo.addReview(
        referenceType: referenceType,
        referenceId: referenceId,
        rating: rating,
        comment: comment,
      );

      emit(state.copyWith(isSubmitting: false));

      await loadReviews(referenceType: referenceType, referenceId: referenceId);

      return true;
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));

      return false;
    }
  }

  Future<bool> deleteReview({
    required int reviewId,
    required String referenceType,
    required int referenceId,
  }) async {
    emit(state.copyWith(isDeleting: true, errorMessage: null));

    try {
      await reviewsRepo.deleteReview(reviewId);

      emit(state.copyWith(isDeleting: false));

      await loadReviews(referenceType: referenceType, referenceId: referenceId);

      return true;
    } on ServerException catch (e) {
      final message = e.errModel.status == 403
          ? 'You can only delete your own reviews.'
          : e.errModel.errorMessage;

      emit(state.copyWith(isDeleting: false, errorMessage: message));

      return false;
    } catch (e) {
      emit(
        state.copyWith(
          isDeleting: false,
          errorMessage: 'Failed to delete review. Please try again.',
        ),
      );

      return false;
    }
  }
}
