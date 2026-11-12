import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/di/dependancy_injection.dart';
import 'package:tourist_app/core/routing/routes.dart';
import 'package:tourist_app/core/widgets/nav_bar_widget.dart';
import 'package:tourist_app/features/auth/view/login_view/login_screen.dart';
import 'package:tourist_app/features/auth/view_model/login_cubit/login_cubit.dart';
import 'package:tourist_app/features/auth/view/signup_view/signup_screen.dart';
import 'package:tourist_app/features/auth/view_model/signup_cubit/signup_cubit.dart';
import 'package:tourist_app/features/guide_panel/view/guide_nav_bar_widget.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
        );
      case Routes.navBar:
        return MaterialPageRoute(builder: (_) => const NavBarWidget());

      case Routes.guideNavBar:
        return MaterialPageRoute(builder: (_) => const GuideNavBarWidget());
      default:
        return null;
    }
  }
}
