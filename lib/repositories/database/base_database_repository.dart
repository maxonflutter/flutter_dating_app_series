import 'package:flutter_dating_app/models/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser(String userId);
  Stream<List<User>> getUsers(User user);
  Future<List<User>> getUsersV2(User user);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> updateUserPictures(User user, String imageName);
  Future<void> updateUserSwipe(
    String userId,
    String matchId,
    bool isSwipeRight,
  );
}
