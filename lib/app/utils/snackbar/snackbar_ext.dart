import 'package:flutter/material.dart';

extension SnackBarExt on BuildContext {
  void showSnackBar(String message, {bool isError = false}) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor:
              isError ? Colors.red.shade400 : Colors.green.shade400,
        ),
      );

  void hideSnackBar(
          {SnackBarClosedReason reason = SnackBarClosedReason.hide}) =>
      ScaffoldMessenger.of(this).hideCurrentSnackBar(reason: reason);

  void clearAllSnackBars() => ScaffoldMessenger.of(this).clearSnackBars();

  void showSnackBarWithAction(
    String message, {
    required String actionLabel,
    required VoidCallback onAction,
    bool isError = false,
  }) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor:
              isError ? Colors.red.shade400 : Colors.green.shade400,
          action: SnackBarAction(
            label: actionLabel,
            onPressed: onAction,
          ),
        ),
      );
}
