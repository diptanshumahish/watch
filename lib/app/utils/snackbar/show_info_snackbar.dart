import 'package:flutter/material.dart';

import '../../../src/app.dart';

void showSnackbar(String message, {Color? backgroundColor}) =>
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
      ),
    );

void showSnackbarWithAction(
  String message, {
  required String actionLabel,
  required VoidCallback onAction,
  Color? backgroundColor,
}) =>
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
        action: SnackBarAction(
          label: actionLabel,
          onPressed: onAction,
        ),
      ),
    );

void hideSnackbar({SnackBarClosedReason reason = SnackBarClosedReason.hide}) =>
    scaffoldMessengerKey.currentState!.hideCurrentSnackBar(reason: reason);

void clearAllSnackbars() => scaffoldMessengerKey.currentState!.clearSnackBars();
