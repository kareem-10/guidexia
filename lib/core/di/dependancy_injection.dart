import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/dio_consumer.dart';
import 'package:tourist_app/core/helpers/cache_helper.dart';
import 'package:tourist_app/features/explore/data/repos/explore_repo.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_cubit.dart';
import 'package:tourist_app/features/login/data/repos/login_repo.dart';
import 'package:tourist_app/features/login/view_model/cubit/login_cubit.dart';
import 'package:tourist_app/features/profile/data/repos/profile_repo.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';
import 'package:tourist_app/features/signup/data/repos/signup_repo.dart';
import 'package:tourist_app/features/signup/view_model/cubit/signup_cubit.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // ApiService
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(getIt()));

  // CacheHelper
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());

  // Dio & ApiService
  //Dio dio = DioFactory.getDio();

  // getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // profile
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));

  // Explore
  getIt.registerLazySingleton<ExploreRepo>(() => ExploreRepo());

  getIt.registerFactory<ExploreCubit>(() => ExploreCubit(getIt()));
}
