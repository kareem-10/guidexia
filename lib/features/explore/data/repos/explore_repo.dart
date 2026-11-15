import 'package:dartz/dartz.dart';
import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/core/error/exceptions.dart';
import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';

class ExploreRepo {
  final ApiConsumer apiConsumer;
  ExploreRepo(this.apiConsumer);

  Future<Either<Failure, List<PlaceModel>>> getPlaces() async {
    try {
      final response = await apiConsumer.get(EndPoints.places);

      final places = (response as List)
          .map((place) => PlaceModel.fromJson(Map<String, dynamic>.from(place)))
          .toList();

      return Right(places);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
