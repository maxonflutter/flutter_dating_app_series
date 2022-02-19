import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '/models/models.dart';
import '/repositories/repositories.dart';

class StorageRepository extends BaseStorageRepository {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(User user, XFile image) async {
    try {
      await storage
          .ref('${user.id}/${image.name}')
          .putFile(
            File(image.path),
          )
          .then(
            (p0) => DatabaseRepository().updateUserPictures(
              user,
              image.name,
            ),
          );
    } catch (err) {
      print(err);
    }
  }

  @override
  Future<String> getDownloadURL(User user, String imageName) async {
    String downloadURL =
        await storage.ref('${user.id}/$imageName').getDownloadURL();
    return downloadURL;
  }
}
