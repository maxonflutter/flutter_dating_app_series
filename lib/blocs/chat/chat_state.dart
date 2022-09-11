part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final Chat chat;

  const ChatLoaded({required this.chat});

  @override
  List<Object?> get props => [chat];
}

class ChatDeleted extends ChatState {
  const ChatDeleted();
}
