import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:watch/providers/user_provider.dart';

abstract class DisposableProvider with ChangeNotifier {
  void logoutDispose();
}

///This class is useful when you want to dispose all the providers
///when the user logs out
class GlobalProviders {
  ///List of all the providers that need to be disposed when the user logs out
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      context.read<UserNotifier>(),
    ];
  }

  ///Method to dispose all the providers when the user logs out
  static Future<void> disposeAllDisposableProviders(
      BuildContext context) async {
    for (final provider in getDisposableProviders(context)) {
      provider.logoutDispose();
    }
  }
}
