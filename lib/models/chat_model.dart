import 'package:equatable/equatable.dart';

import 'message_model.dart';

class Chat extends Equatable {
  final String id;
  final String userId;
  final String matchedUserId;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.userId,
    required this.matchedUserId,
    required this.messages,
  });

  @override
  List<Object?> get props => [id, userId, matchedUserId, messages];

  static List<Chat> chats = [
    Chat(
      id: '1',
      userId: '1',
      matchedUserId: '2',
      messages: Message.messages
          .where((message) =>
              (message.senderId == 1 && message.receiverId == 2) ||
              (message.senderId == 2 && message.receiverId == 1))
          .toList(),
    ),
  ];
}
