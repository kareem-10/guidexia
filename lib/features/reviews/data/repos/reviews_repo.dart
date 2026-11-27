import 'package:dartz/dartz.dart';

import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/core/error/exceptions.dart';
import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/reviews/data/models/review_model.dart';

class ReviewsRepo {
  final ApiConsumer apiConsumer;

  ReviewsRepo(this.apiConsumer);

  Future<Either<Failure, List<ReviewModel>>> getReviews({
    required String referenceType,
    required int referenceId,
  }) async {
    try {
      final response = await apiConsumer.get(
        EndPoints.reviews,
        queryParameters: {
          'referenceType': referenceType,
          'referenceId': referenceId,
        },
      );

      final List data = response is List ? response : response['data'] as List;

      final reviews = data
          .map(
            (review) =>
                ReviewModel.fromJson(Map<String, dynamic>.from(review as Map)),
          )
          .toList();

      return Right(reviews);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ReviewModel>> addReview({
    required String referenceType,
    required int referenceId,
    required int rating,
    required String comment,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.reviews,
        data: {
          'referenceType': referenceType,
          'referenceId': referenceId,
          'rating': rating,
          'comment': comment,
        },
      );

      final data = response is Map && response.containsKey('data')
          ? response['data']
          : response;

      final review = ReviewModel.fromJson(
        Map<String, dynamic>.from(data as Map),
      );

      return Right(review);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteReview(int reviewId) async {
    try {
      await apiConsumer.delete(EndPoints.reviewById(reviewId));
      return const Right(null);
    } on ServerException catch (e) {
      final message = e.errModel.status == 403
          ? 'You can only delete your own reviews.'
          : e.errModel.errorMessage;

      return Left(ServerFailure(message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
