import 'package:dartz/dartz.dart';
import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/end_ponits.dart';
import 'package:tourist_app/core/error/exceptions.dart';
import 'package:tourist_app/core/helpers/secure_storage_helper.dart';
import 'package:tourist_app/features/auth/data/models/auth_model.dart';

class SignupRepo {
  final ApiConsumer api;
  final SecureStorageHelper secureStorage;

  SignupRepo(this.api, this.secureStorage);

  Future<Either<String, AuthModel>> signUp({
    required String firstName,
    String lastName = '',
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await api.post(
        EndPoints.signUp,
        data: {
          ApiKey.firstName: firstName,
          ApiKey.lastName: lastName,
          ApiKey.email: email,
          ApiKey.password: password,
          ApiKey.role: role,
        },
      );
      final user = AuthModel.fromJson(response);

      await secureStorage.saveToken(user.token);
      await secureStorage.saveUserId(user.userId);

      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left('Something went wrong. Please try again.');
    }
  }
}
