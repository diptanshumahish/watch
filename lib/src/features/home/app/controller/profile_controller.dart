//profile controller to pick and upload images to firebase storage

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/firebase_storage_provider.dart';
import '../../../../providers/user_provider.dart';

//LogoutNotifier is the same as the one in logout_controller.dart
final AutoDisposeChangeNotifierProvider<ProfileNotifier> profileNotifier =
    ChangeNotifierProvider.autoDispose<ProfileNotifier>(
  (AutoDisposeChangeNotifierProviderRef<ProfileNotifier> ref) =>
      ProfileNotifier(
    ref.watch(cloudStorageAPI),
    ref.watch(userNotifierProvider.notifier),
  ),
);

class ProfileNotifier extends ChangeNotifier {
  ProfileNotifier(this._storageAPI, this._userNotifier);

  late final CloudStorageAPI _storageAPI;
  late final UserNotifier _userNotifier;

  String? get userPhotoURL => _photoURL;
  String? _photoURL;

  Future<void> getDownloadURL() async {
    _photoURL = await _storageAPI.getDownloadURL(_userNotifier.user.uid!);
  }

  Future<void> uploadFile(File file) async {
    await _storageAPI.uploadFile(_userNotifier.user.uid!, file);
  }
}
