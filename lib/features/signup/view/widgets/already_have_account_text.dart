import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tourist_app/core/helpers/extentions.dart';
import 'package:tourist_app/core/routing/routes.dart';
import 'package:tourist_app/core/theming/styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account?',
            style: TextStyles.font12GreyRegular,
          ),
          TextSpan(
            text: ' Login',
            style: TextStyles.font14PrimaryMedium,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(Routes.loginScreen);
              },
          ),
        ],
      ),
    );
  }
}
