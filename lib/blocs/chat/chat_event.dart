part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatLoad extends ChatEvent {
  final String? chatId;

  const ChatLoad(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class ChatAddMessage extends ChatEvent {
  final String userId;
  final String matchedUserId;
  final String text;

  const ChatAddMessage({
    required this.userId,
    required this.matchedUserId,
    required this.text,
  });

  @override
  List<Object?> get props => [userId, matchedUserId, text];
}

class ChatUpdate extends ChatEvent {
  final Chat chat;

  const ChatUpdate({required this.chat});

  @override
  List<Object?> get props => [chat];
}
