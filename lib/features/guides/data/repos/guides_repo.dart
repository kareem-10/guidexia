import 'package:dartz/dartz.dart';
import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/core/error/exceptions.dart';
import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/guides/data/models/guide_model.dart';

class GuidesRepo {
  final ApiConsumer _apiConsumer;
  GuidesRepo(this._apiConsumer);

  Future<Either<Failure, List<GuideModel>>> getGuides() async {
    try {
      final response = await _apiConsumer.get(EndPoints.guides);

      final guides = (response as List)
          .map(
            (guide) =>
                GuideModel.fromJson(Map<String, dynamic>.from(guide as Map)),
          )
          .toList();

      return Right(guides);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, GuideModel>> getGuideDetails(int id) async {
    try {
      final response = await _apiConsumer.get(EndPoints.guideById(id));

      final guide = GuideModel.fromJson(
        Map<String, dynamic>.from(response as Map),
      );

      return (right(guide));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
