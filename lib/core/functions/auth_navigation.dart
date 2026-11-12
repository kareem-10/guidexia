import 'package:flutter/material.dart';
import 'package:tourist_app/core/functions/show_toast.dart';
import 'package:tourist_app/core/routing/routes.dart';
import 'package:tourist_app/features/auth/data/models/auth_model.dart';

class AuthNavigation {
  static void navigateByRole(BuildContext context, AuthModel user) {
    final role = user.role;

    late final String destination;

    switch (role) {
      case 'Tourist':
        destination = Routes.navBar;
        break;

      case 'TourGuide':
        destination = Routes.guideNavBar;
        break;

      default:
        showToast('Unable to identify your account role.');
        return;
    }

    Navigator.pushNamedAndRemoveUntil(context, destination, (route) => false);
  }
}
