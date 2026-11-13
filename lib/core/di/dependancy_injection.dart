import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tourist_app/core/api/api_consumer.dart';
import 'package:tourist_app/core/api/dio_consumer.dart';
import 'package:tourist_app/core/helpers/cache_helper.dart';
import 'package:tourist_app/core/helpers/secure_storage_helper.dart';
import 'package:tourist_app/features/explore/data/repos/explore_repo.dart';
import 'package:tourist_app/features/explore/view_model/cubit/explore_cubit.dart';
import 'package:tourist_app/features/guides/data/repos/guides_repo.dart';
import 'package:tourist_app/features/guides/view_model/cubit/guides_cubit.dart';
import 'package:tourist_app/features/auth/data/repos/login_repo.dart';
import 'package:tourist_app/features/auth/view_model/login_cubit/login_cubit.dart';
import 'package:tourist_app/features/profile/data/repos/profile_repository.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';
import 'package:tourist_app/features/saved/data/repos/saved_repo.dart';
import 'package:tourist_app/features/saved/view_model/cubit/saved_cubit.dart';
import 'package:tourist_app/features/auth/data/repos/signup_repo.dart';
import 'package:tourist_app/features/auth/view_model/signup_cubit/signup_cubit.dart';
import 'package:tourist_app/features/stays/data/repos/stay_repository.dart';
import 'package:tourist_app/features/stays/view_model/cubit/stay_cubit.dart';

import 'package:tourist_app/core/theming/theme_cubit/theme_cubit.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt({CacheHelper? cacheHelper}) async {
  // Shared Preferences
  final cache = cacheHelper ?? CacheHelper();

  getIt.registerLazySingleton<CacheHelper>(() => cache);

  // Secure Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<SecureStorageHelper>(
    () => SecureStorageHelper(getIt()),
  );

  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // API Consumer
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(getIt<Dio>(), getIt<SecureStorageHelper>()),
  );

  // Theming
  getIt.registerLazySingleton<ThemeCubit>(() {
    final cubit = ThemeCubit(getIt());
    cubit.loadSavedTheme();
    return cubit;
  });

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt(), getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt(), getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // profile
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(getIt()),
  );
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));

  // Explore
  getIt.registerLazySingleton<ExploreRepo>(() => ExploreRepo());

  getIt.registerFactory<ExploreCubit>(() => ExploreCubit(getIt()));

  // Guides
  getIt.registerLazySingleton<GuidesRepo>(() => GuidesRepo());
  getIt.registerFactory<GuidesCubit>(() => GuidesCubit(getIt<GuidesRepo>()));

  // Stays
  getIt.registerLazySingleton<StayRepository>(() => StayRepository());
  getIt.registerFactory<StayCubit>(() => StayCubit(getIt()));

  // Saved / Favorites
  getIt.registerLazySingleton<SavedRepository>(() => SavedRepository());

  getIt.registerFactory<SavedCubit>(
    () => SavedCubit(
      getIt<SavedRepository>(),
      getIt<ExploreRepo>(),
      getIt<GuidesRepo>(),
      getIt<StayRepository>(),
    ),
  );
}
