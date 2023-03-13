import 'package:flutter/material.dart';

extension LoadingDialogExt on BuildContext {
  void showLoaderDialog() => Loader.show(this);

  void hideLoaderDialog() => Loader.hide(this);
}

class Loader {
  ///Show a Loader while some future call is being made
  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future<bool>.value(false),
          child: const AlertDialog(
            elevation: 0,
            backgroundColor: Colors.white,
            content: SizedBox(
              height: 60,
              width: 60,
              child: Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///Hide the loading dialog once future call is finished
  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}
