part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final Chat chat;
  final String? messageText;

  const ChatLoaded({
    required this.chat,
    this.messageText = '',
  });

  @override
  List<Object?> get props => [chat, messageText];
}
