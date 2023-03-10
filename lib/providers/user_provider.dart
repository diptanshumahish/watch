import 'package:flutter/widgets.dart';
import 'package:watch/models/user_model.dart';

class UserNotifier extends ChangeNotifier {
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
  void notifyListeners() {
    if (_mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _mounted = false;

    super.dispose();
  }
}
