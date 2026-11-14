import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/routing/routes.dart';
import 'package:tourist_app/features/profile/view_model/cubit/profile_cubit.dart';

void confirmLogout(BuildContext context) {
  final profileCubit = context.read<ProfileCubit>();

  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Log out?'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
        FilledButton(
          onPressed: () async {
            Navigator.pop(dialogContext);

            await profileCubit.logout();

            if (!context.mounted) return;

            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
          },
          child: const Text('Log out'),
        ),
      ],
    ),
  );
}
