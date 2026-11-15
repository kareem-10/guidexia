import 'package:dartz/dartz.dart';
import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/core/error/exceptions.dart';
import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/place_details/data/models/activity_model.dart';

class PlaceDetailsRepo {
  final ApiConsumer apiConsumer;
  PlaceDetailsRepo(this.apiConsumer);

  Future<Either<Failure, List<ActivityModel>>> getActivities(
    int placeId,
  ) async {
    try {
      final response = await apiConsumer.get(
        EndPoints.placeActivities(placeId),
      );

      final activities = (response as List)
          .map(
            (activity) => ActivityModel.fromJson(
              Map<String, dynamic>.from(activity as Map),
            ),
          )
          .toList();

      return Right(activities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
