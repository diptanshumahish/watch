import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch/app/errors/errors.dart';
import 'package:watch/src/models/movie_details_model.dart';
import 'package:watch/src/models/user_model.dart';
import 'package:watch/src/providers/user_provider.dart';

///Provider that will be used to provide the firestore instance
final Provider<FirebaseFirestore> firestoreProvider =
    Provider<FirebaseFirestore>(
  name: 'firestoreProvider',
  (ProviderRef<FirebaseFirestore> ref) => FirebaseFirestore.instance,
);

///Provider that will be used to provide the firestore service
final firestoreServiceProvider = Provider.autoDispose<CloudFirestoreAPI>(
  name: 'firestoreServiceProvider',
  (ref) => CloudFirestoreAPI(
    firestore: ref.watch(firestoreProvider),
    userNotifier: ref.watch(userNotifierProvider.notifier),
  ),
);

class CloudFirestoreAPI {
  late final FirebaseFirestore _firestore;
  late final UserNotifier _userNotifier;
  CloudFirestoreAPI(
      {required FirebaseFirestore firestore,
      required UserNotifier userNotifier})
      : _firestore = firestore,
        _userNotifier = userNotifier;

  ///Get the collection reference
  ///[collectionPath] is the path of the collection
  CollectionReference<Map<String, dynamic>> getCollection(
          String collectionPath) =>
      _firestore.collection(collectionPath);

  ///Get the document reference
  ///[collectionPath] is the path of the collection
  ///[documentPath] is the path of the document
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
          String collectionPath, String documentPath) =>
      _firestore.collection(collectionPath).doc(documentPath).get();

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

  ///Fecth all the liked items of the user
  ///[userId] is the id of the user
  FutureEither<Map<String, dynamic>> fetchLikedMovies() async {
    try {
      if (_userNotifier.user.uid == null) {
        return left(const Failure(message: 'User not found'));
      }
      final fetchRes = await getDocument('User', _userNotifier.user.uid!);
      return right(fetchRes.data() ?? {});
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  ///Add to the liked items list in the firebase database
  ///[userId] is the id of the user
  FutureEitherUnit addLikedItem({
    required Result likedItem,
    String collectionPath = 'User',
  }) async {
    try {
      if (_userNotifier.user.uid == null) {
        return left(const Failure(message: 'User not found'));
      }
      await _firestore
          .collection(collectionPath)
          .doc(_userNotifier.user.uid!)
          .update({
        'likedItems': FieldValue.arrayUnion([likedItem.toJson()])
      });
      _userNotifier.updateLikedItems(likedItem);
      return right(unit);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  ///Remove from the liked items list in the firebase database
  ///[userId] is the id of the user
  FutureEitherUnit removeLikedItem({
    required Result dislikedItem,
    String collectionPath = 'User',
  }) async {
    try {
      if (_userNotifier.user.uid == null) {
        return left(const Failure(message: 'User not found'));
      }
      await _firestore
          .collection(collectionPath)
          .doc(_userNotifier.user.uid!)
          .update({
        'likedItems': FieldValue.arrayRemove([dislikedItem.toJson()])
      });
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
