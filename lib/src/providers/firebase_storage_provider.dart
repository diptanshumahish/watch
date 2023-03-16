import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<Reference> storageReferenceProvider = Provider<Reference>(
    (ProviderRef<Reference> ref) => FirebaseStorage.instance.ref());

final Provider<CloudStorageAPI> cloudStorageAPI =
    Provider<CloudStorageAPI>((ProviderRef<CloudStorageAPI> ref) {
  return CloudStorageAPI(ref.watch(storageReferenceProvider));
});

class CloudStorageAPI {
  late Reference ref;
  CloudStorageAPI(this.ref);

  //upload image to firebase storage
  Future<void> uploadFile(String path, File file) async {
    await ref.child(path).putFile(file);
  }

  Future<String> getDownloadURL(String path) async {
    return ref.child(path).getDownloadURL();
  }
}
