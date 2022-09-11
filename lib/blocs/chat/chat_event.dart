part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChat extends ChatEvent {
  final String? chatId;

  const LoadChat(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class UpdateChat extends ChatEvent {
  final Chat chat;

  const UpdateChat({required this.chat});

  @override
  List<Object?> get props => [chat];
}

class AddMessage extends ChatEvent {
  final String userId;
  final String matchUserId;
  final String message;

  const AddMessage({
    required this.userId,
    required this.matchUserId,
    required this.message,
  });

  @override
  List<Object?> get props => [userId, matchUserId, message];
}

class DeleteChat extends ChatEvent {
  final String userId;
  final String matchUserId;

  const DeleteChat({
    required this.userId,
    required this.matchUserId,
  });

  @override
  List<Object?> get props => [userId, matchUserId];
}
