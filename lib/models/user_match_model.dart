import 'package:equatable/equatable.dart';
import 'models.dart';

class UserMatch extends Equatable {
  final int id;
  final int userId;
  final User matchedUser;
  final List<Chat>? chat;

  UserMatch({
    required this.id,
    required this.userId,
    required this.matchedUser,
    this.chat,
  });

  @override
  List<Object?> get props => [id, userId, matchedUser];

  static List<UserMatch> matches = [
    UserMatch(
      id: 1,
      userId: 1,
      matchedUser: User.users[1],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.otherUserId == 2)
          .toList(),
    ),
    UserMatch(
      id: 2,
      userId: 1,
      matchedUser: User.users[2],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.otherUserId == 3)
          .toList(),
    ),
    UserMatch(
      id: 3,
      userId: 1,
      matchedUser: User.users[3],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.otherUserId == 4)
          .toList(),
    ),
    UserMatch(
      id: 4,
      userId: 1,
      matchedUser: User.users[4],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.otherUserId == 5)
          .toList(),
    ),
    UserMatch(
      id: 5,
      userId: 1,
      matchedUser: User.users[5],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.otherUserId == 6)
          .toList(),
    ),
    UserMatch(
      id: 6,
      userId: 1,
      matchedUser: User.users[6],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.otherUserId == 7)
          .toList(),
    ),
    UserMatch(
      id: 7,
      userId: 1,
      matchedUser: User.users[7],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.otherUserId == 8)
          .toList(),
    ),
    UserMatch(
      id: 8,
      userId: 1,
      matchedUser: User.users[8],
      chat: Chat.chats
          .where((chat) => chat.userId == 1 && chat.otherUserId == 9)
          .toList(),
    ),
  ];
}
