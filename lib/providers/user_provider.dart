import 'package:watch/models/user_model.dart';
import 'package:watch/providers/disposable_provider/disposable_provider.dart';

class UserNotifier extends DisposableProvider {
  UserNotifier() : _mounted = true;

  bool _mounted;

  bool get isLoggedIn => _user != null;

  UserModel? _user;
  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  @override
  void logoutDispose() {
    _user = null;
  }

  @override
  void notifyListeners() {
    if (_mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _mounted = false;
    logoutDispose();
    super.dispose();
  }
}
