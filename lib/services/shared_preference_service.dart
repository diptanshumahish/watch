import 'dart:convert';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/models/user_model.dart';

import '../providers/multi_provider.dart';

final localStorageAPIProvider = Provider<LocalStorageAPI>(
  (ref) => LocalStorageAPI(ref.watch(sharedPreferenceProvider)),
);

class LocalStorageAPI {
  late final SharedPreferences _prefs;

  LocalStorageAPI(SharedPreferences prefs) : _prefs = prefs;

  ///Save current user data into the disk
  ///Returns [true] if the data is saved successfully
  Future<bool> setUser({
    required String displayName,
    required String age,
    required String email,
    bool? isAdult = false,
  }) async {
    return await setValue<String>(
      'user',
      jsonEncode(UserModel(
        displayName: displayName,
        age: age,
        email: email,
        isAdult: isAdult ?? false,
      )),
    );
  }

  ///Get the current user data from the disk
  UserModel? getUser() {
    String? currentUser = getValue<String>('user');
    if (currentUser != null) {
      return UserModel.fromJson(
          jsonDecode(currentUser) as Map<String, dynamic>);
    }
    return null;
  }

  ///Clear the current user data from the disk
  ///Returns [true] if the data is cleared successfully
  Future<bool> clearUser() async {
    return await remove('user');
  }

  ///Remove a particular entry from the disk
  ///Returns [true] if the data is removed successfully
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  ///Check if the key exists in the disk
  bool containsKey(String key) => _prefs.containsKey(key);

  ///Save the current theme to the disk
  Future<bool> setTheme(bool isDarkMode) async {
    return await setValue<bool>('isDark', isDarkMode);
  }

  ///Get the current theme from the disk
  bool getTheme() => getValue<bool>('isDark') ?? false;

  ///Save a value to the disk by passing the [key]
  ///and [value] in the method. Returns [true] if the value is set successfully
  Future<bool> setValue<T>(String key, T value) async {
    if (value is String) {
      return await _prefs.setString(key, value);
    } else if (value is int) {
      return await _prefs.setInt(key, value);
    } else if (value is bool) {
      return await _prefs.setBool(key, value);
    } else if (value is double) {
      return await _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      return await _prefs.setStringList(key, value);
    } else {
      return false;
    }
  }

  ///Get a value from the disk by passing the key in the method
  ///```dart
  /// String? name = getValue<String>('name');
  ///```
  ///Returns null if the value is not found
  T? getValue<T>(String key) {
    try {
      if (T == String) {
        return _prefs.getString(key) as T?;
      } else if (T == int) {
        return _prefs.getInt(key) as T?;
      } else if (T == bool) {
        return _prefs.getBool(key) as T?;
      } else if (T == double) {
        return _prefs.getDouble(key) as T?;
      } else if (T == List<String>) {
        return _prefs.getStringList(key) as T?;
      } else {
        return null;
      }
    } catch (e) {
      log('Error thrown while getting the value from the disk',
          name: 'PrefsService', error: e);
      return null;
    }
  }

  ///Clear all the data from the disk
  ///Returns [true] if the data is cleared successfully
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
