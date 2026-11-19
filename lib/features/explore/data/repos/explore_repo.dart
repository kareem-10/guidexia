import 'package:dartz/dartz.dart';
import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/core/error/exceptions.dart';
import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/explore/data/models/paginated_response.dart';
import 'package:tourist_app/features/explore/data/models/place_model.dart';

class ExploreRepo {
  final ApiConsumer apiConsumer;
  ExploreRepo(this.apiConsumer);

  Future<Either<Failure, PaginatedResponse<PlaceModel>>> getPlaces({
    required int pageIndex,
    required int pageSize,
    String? category,
    bool? featured,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'PageIndex': pageIndex,
        'PageSize': pageSize,
        if (category != null && category != 'All') 'Category': category,
        'Featured': ?featured,
        if (search != null && search.trim().isNotEmpty) 'Search': search.trim(),
      };

      final response = await apiConsumer.get(
        EndPoints.places,
        queryParameters: queryParams,
      );

      final result = PaginatedResponse<PlaceModel>.fromJson(
        Map<String, dynamic>.from(response as Map),
        PlaceModel.fromJson,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
