import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/controller/logout_controller.dart';

class LogoutDialog extends ConsumerWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text(
        'Logout',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: const Text(
        'Are you sure you want to logout?',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () async {
            await ref.read(logoutNotifierProvider.notifier).logout(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
