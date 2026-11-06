import 'package:flutter/material.dart';

void confirmLogout(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Log out?'),
      content: const Text(
        'This is a mock action for now. Connect it to your authentication flow later.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Connect logout to Auth later')),
            );
          },
          child: const Text('Log out'),
        ),
      ],
    ),
  );
}
