import 'package:rxdart/rxdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/models.dart';
import '/repositories/repositories.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    print('Getting user images from DB');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Stream<List<User>> getUsers(User user) {
    return _firebaseFirestore
        .collection('users')
        // .where('gender', isEqualTo: _selectGender(user))
        .where('gender', whereIn: _selectGender(user))
        .snapshots()
        .map((snap) {
      print(snap);
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<User>> getUsersToSwipe(User user) {
    return Rx.combineLatest2(
      getUser(user.id!),
      getUsers(user),
      (
        User currentUser,
        List<User> users,
      ) {
        return users.where(
          (user) {
            bool isCurrentUser = user.id == currentUser.id;
            bool wasSwipedLeft = currentUser.swipeLeft!.contains(user.id);
            bool wasSwipedRight = currentUser.swipeRight!.contains(user.id);
            bool isMatch = currentUser.matches!.contains(user.id);

            bool isWithinAgeRange =
                user.age >= currentUser.ageRangePreference![0] &&
                    user.age <= currentUser.ageRangePreference![1];

            bool isWithinDistance = _getDistance(currentUser, user) <=
                currentUser.distancePreference;

            if (isCurrentUser) return false;
            if (wasSwipedLeft) return false;
            if (wasSwipedRight) return false;
            if (isMatch) return false;
            if (!isWithinAgeRange) return false;
            if (!isWithinDistance) return false;

            return true;
          },
        ).toList();
      },
    );
  }

  @override
  Stream<List<Match>> getMatches(User user) {
    return Rx.combineLatest3(
      getUser(user.id!),
      getChats(user.id!),
      getUsers(user),
      (
        User currentUser,
        List<Chat> currentUserChats,
        List<User> users,
      ) {
        print('Current user chats: $currentUserChats');
        return users
            .where((user) {
              List<String> matches = currentUser.matches!
                  .map((match) => match['matchId'] as String)
                  .toList();
              return matches.contains(user.id);
            })
            .map(
              (user) => Match(
                  userId: currentUser.id!,
                  matchedUser: user,
                  chat: currentUserChats.where((chat) {
                    return (chat.userIds.contains(user.id) &
                        chat.userIds.contains(currentUser.id));
                  }).first),
            )
            .toList();
      },
    );
  }

  @override
  Stream<List<Chat>> getChats(String userId) {
    print(userId);
    return _firebaseFirestore
        .collection('chats')
        .where('userIds', arrayContains: userId)
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => Chat.fromJson(doc.data(), id: doc.id))
          .toList();
    });
  }

  @override
  Stream<Chat> getChat(String chatId) {
    return _firebaseFirestore
        .collection('chats')
        .doc(chatId)
        .snapshots()
        .map((doc) {
      return Chat.fromJson(
        doc.data() as Map<String, dynamic>,
        id: doc.id,
      );
    });
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore.collection('users').doc(user.id).set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toMap())
        .then(
          (value) => print('User document updated.'),
        );
  }

  @override
  Future<void> updateUserPictures(User user, String imageName) async {
    String downloadUrl =
        await StorageRepository().getDownloadURL(user, imageName);

    return _firebaseFirestore.collection('users').doc(user.id).update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl])
    });
  }

  @override
  Future<void> updateUserSwipe(
    String userId,
    String matchId,
    bool isSwipeRight,
  ) async {
    if (isSwipeRight) {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeRight': FieldValue.arrayUnion([matchId])
      });
    } else {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeLeft': FieldValue.arrayUnion([matchId])
      });
    }
  }

  @override
  Future<void> updateUserMatch(
    String userId,
    String matchId,
  ) async {
    // Create a document in the chat collection to store the messages.
    String chatId = await _firebaseFirestore.collection('chats').add({
      'userIds': [userId, matchId],
      'messages': [],
    }).then((value) => value.id);

    // Add the match into the current user document.
    await _firebaseFirestore.collection('users').doc(userId).update({
      'matches': FieldValue.arrayUnion([
        {
          'matchId': matchId,
          'chatId': chatId,
        }
      ])
    });
    // Add the match into the other user document.
    await _firebaseFirestore.collection('users').doc(matchId).update({
      'matches': FieldValue.arrayUnion([
        {
          'matchId': userId,
          'chatId': chatId,
        }
      ])
    });
  }

  @override
  Future<void> addMessage(String chatId, Message message) {
    return _firebaseFirestore.collection('chats').doc(chatId).update({
      'messages': FieldValue.arrayUnion(
        [
          Message(
            senderId: message.senderId,
            receiverId: message.receiverId,
            message: message.message,
            dateTime: message.dateTime,
            timeString: message.timeString,
          ).toJson()
        ],
      )
    });
  }

  _selectGender(User user) {
    if (user.genderPreference == null) {
      return ['Male', 'Female'];
    }
    return user.genderPreference;
  }

  _getDistance(User currentUser, User user) {
    GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    var distanceInKm = geolocator.distanceBetween(
          currentUser.location!.lat.toDouble(),
          currentUser.location!.lon.toDouble(),
          user.location!.lat.toDouble(),
          user.location!.lon.toDouble(),
        ) ~/
        1000;
    print(
        'Distance in KM between ${currentUser.name} & ${user.name}: $distanceInKm');
    return distanceInKm;
  }
}
