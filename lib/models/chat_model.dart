import 'package:equatable/equatable.dart';

import 'message_model.dart';

class Chat extends Equatable {
  final String id;
  final List<String> userIds;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.userIds,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json, {String? id}) {
    // List<User> users = (json['users'] as List)
    //     .map((user) => user as String)
    //     .toList()
    //     .map((userId) {
    //   return User.empty.copyWith(id: userId);
    // }).toList();

    List<Message> messages = (json['messages'] as List)
        .map((message) => Message.fromJson(message))
        .toList();

    List<String> userIds =
        (json['userIds'] as List).map((userId) => userId as String).toList();

    messages.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return Chat(
      id: id ?? json['id'],
      userIds: userIds,
      messages: messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userIds': userIds,
      'messages': messages,
    };
  }

  @override
  List<Object?> get props => [id, userIds, messages];
}
