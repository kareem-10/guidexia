import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tourist_app/core/di/dependancy_injection.dart';
import 'package:tourist_app/core/helpers/cache_helper.dart';
import 'package:tourist_app/core/routing/app_router.dart';
import 'package:tourist_app/core/routing/routes.dart';
import 'package:tourist_app/core/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Tourist App',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.offWhite,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.navBar,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}

//nothing
