import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/app/errors/errors.dart';
import 'package:watch/src/models/user_model.dart';

///Provider that will be used to provide the firestore instance
final Provider<FirebaseFirestore> firestoreProvider =
    Provider<FirebaseFirestore>(
  (ProviderRef<FirebaseFirestore> ref) => FirebaseFirestore.instance,
);

///Provider that will be used to provide the firestore service
final firestoreServiceProvider = Provider.autoDispose<CloudFirestoreAPI>((ref) {
  return CloudFirestoreAPI(firestore: ref.watch(firestoreProvider));
});

class CloudFirestoreAPI {
  late final FirebaseFirestore _firestore;
  CloudFirestoreAPI({required FirebaseFirestore firestore})
      : _firestore = firestore;

  ///Get the collection reference
  ///[collectionPath] is the path of the collection
  CollectionReference<Map<String, dynamic>> getCollection(
          String collectionPath) =>
      _firestore.collection(collectionPath);

  ///Get the document reference
  ///[collectionPath] is the path of the collection
  ///[documentPath] is the path of the document
  DocumentReference<Map<String, dynamic>> getDocument(
          String collectionPath, String documentPath) =>
      _firestore.collection(collectionPath).doc(documentPath);

  ///Get the subcollection reference
  ///[collectionPath] is the path of the collection
  ///[documentPath] is the path of the document
  ///[subCollectionPath] is the path of the subcollection
  CollectionReference<Map<String, dynamic>> getSubCollection(
          String collectionPath,
          String documentPath,
          String subCollectionPath) =>
      _firestore
          .collection(collectionPath)
          .doc(documentPath)
          .collection(subCollectionPath);

  ///Set the user details to the Employee collection associated with the userid
  ///[userId] is the id of the user
  FutureEitherUnit setUserDetails({
    required String userId,
    String collectionPath = 'User',
    required UserModel data,
  }) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(userId)
          .set(data.toJson());
      return right(unit);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  ///Add to the liked items list in the firebase database
  ///[userId] is the id of the user
  FutureEitherUnit addLikedItem({
    required String userId,
    required List<String> likedItems,
    String collectionPath = 'User',
  }) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(userId)
          .update({'likedItems': FieldValue.arrayUnion(likedItems)});
      return right(unit);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  ///Remove from the liked items list in the firebase database
  ///[userId] is the id of the user
  FutureEitherUnit removeLikedItem({
    required String userId,
    required List<String> dislikedItems,
    String collectionPath = 'User',
  }) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(userId)
          .update({'likedItems': FieldValue.arrayRemove(dislikedItems)});
      return right(unit);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  ///Add to the selected genres list in the firebase database
  ///[userId] is the id of the user
  FutureEitherUnit addSelectedGenres({
    required String userId,
    required List<String> genres,
    String collectionPath = 'User',
  }) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(userId)
          .update({'selectedGenres': FieldValue.arrayUnion(genres)});
      return right(unit);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  ///Remove from the selected genres list in the firebase database
  ///[userId] is the id of the user
  FutureEitherUnit removeGenre({
    required String userId,
    required String genre,
    String collectionPath = 'User',
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(userId).update({
        'selectedGenres': FieldValue.arrayRemove([genre])
      });
      return right(unit);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  ///Add a document to the collection type based on the [UserRole]
  ///[userId] is the id of the user
  FutureEitherUnit addDocument(Map<String, dynamic> doc,
      {String collectionPath = 'User'}) async {
    try {
      await _firestore.collection(collectionPath).add(doc);
      return right(unit);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
