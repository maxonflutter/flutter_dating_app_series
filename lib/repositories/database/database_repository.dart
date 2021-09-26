import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dating_app/models/user_model.dart';
import 'package:flutter_dating_app/repositories/database/base_database_repository.dart';
import 'package:flutter_dating_app/repositories/storage/storage_repository.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser() {
    return _firebaseFirestore
        .collection('users')
        .doc('C00l8bytMieXkp0K5ePt')
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUserPictures(String imageName) async {
    String downloadUrl = await StorageRepository().getDownloadURL(imageName);

    return _firebaseFirestore
        .collection('users')
        .doc('C00l8bytMieXkp0K5ePt')
        .update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }
}
