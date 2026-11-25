import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/features/reviews/data/models/review_model.dart';

class ReviewsRepo {
  final ApiConsumer _apiConsumer;
  ReviewsRepo(this._apiConsumer);

  Future<List<ReviewModel>> getReviews({
    required String referenceType,
    required int referenceId,
  }) async {
    final response = await _apiConsumer.get(
      EndPoints.reviews,
      queryParameters: {
        'referenceType': referenceType,
        'referenceId': referenceId,
      },
    );

    final List data = response is List ? response : response['data'] as List;

    return data.map((review) => ReviewModel.fromJson(review)).toList();
  }

  Future<ReviewModel> addReview({
    required String referenceType,
    required int referenceId,
    required int rating,
    required String comment,
  }) async {
    final response = await _apiConsumer.post(
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

    return ReviewModel.fromJson(data);
  }

  Future<void> deleteReview(int reviewId) async {
    await _apiConsumer.delete(EndPoints.reviewById(reviewId));
  }
}
