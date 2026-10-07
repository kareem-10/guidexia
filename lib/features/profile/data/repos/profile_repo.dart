import 'package:dartz/dartz.dart';
import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/core/error/exceptions.dart';
import 'package:tourist_app/core/helpers/cache_helper.dart';
import 'package:tourist_app/features/profile/data/models/profile_model.dart';

class ProfileRepo {
  final ApiConsumer api;

  ProfileRepo(this.api);

  Future<Either<String, ProfileModel>> getUserProfile() async {
    try {
      final response = await api.get(
        EndPoints.getUserDataEndPoint(CacheHelper().getData(key: ApiKey.id)),
      );
      return Right(ProfileModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }
}
