import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/di/dependancy_injection.dart';
import 'package:tourist_app/core/helpers/cache_helper.dart';
import 'package:tourist_app/core/routing/app_router.dart';
import 'package:tourist_app/core/routing/routes.dart';
import 'package:tourist_app/core/theming/app_theme.dart';
import 'package:tourist_app/core/theming/theme_cubit/theme_cubit.dart';
import 'package:tourist_app/core/theming/theme_cubit/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  await setupGetIt(cacheHelper: cacheHelper);
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ThemeCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          buildWhen: (previous, current) =>
              previous.themeMode != current.themeMode,
          builder: (context, state) => MaterialApp(
            title: 'Tourist App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.navBar,
            onGenerateRoute: appRouter.generateRoute,
          ),
        ),
      ),
    );
  }
}

//nothing
