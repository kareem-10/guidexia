import 'package:dartz/dartz.dart';
import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/core/error/exceptions.dart';
import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/saved/data/models/saved_model.dart';

class SavedRepository {
  final ApiConsumer apiConsumer;

  SavedRepository(this.apiConsumer);

  // Get all saved items or filter by entity type.
  Future<Either<Failure, List<SavedModel>>> getSaves({
    String? entityType,
  }) async {
    try {
      final response = await apiConsumer.get(
        EndPoints.favorites,
        queryParameters: entityType == null ? null : {'entityType': entityType},
      );

      final saves = (response as List)
          .map(
            (item) =>
                SavedModel.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList();

      return Right(saves);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Add or remove an item from favorites.
  Future<Either<Failure, SavedModel>> toggleSaves({
    required String entityType,
    required int entityId,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.favoritesToggle,
        data: {'entityType': entityType, 'entityId': entityId},
      );

      final save = SavedModel.fromJson(
        Map<String, dynamic>.from(response as Map),
      );

      return Right(save);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Check whether an item is saved.
  Future<Either<Failure, bool>> checkSave({
    required String entityType,
    required int entityId,
  }) async {
    try {
      final response = await apiConsumer.get(
        EndPoints.favoritesCheck,
        queryParameters: {'entityType': entityType, 'entityId': entityId},
      );

      return Right(response as bool);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
