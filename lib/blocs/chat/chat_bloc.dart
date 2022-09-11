import 'dart:async';

import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/models/models.dart';
import '/repositories/repositories.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _chatSubscription;

  ChatBloc({
    required DatabaseRepository databaseRepository,
  })  : _databaseRepository = databaseRepository,
        super(ChatLoading()) {
    on<ChatLoad>(_onChatLoad);
    on<ChatAddMessage>(_onChatAddMessage);
    on<ChatUpdate>(_onChatUpdate);

    if (state is ChatLoaded) {
      _chatSubscription = _databaseRepository
          .getChat((state as ChatLoaded).chat.id)
          .listen((chat) {
        add(ChatUpdate(chat: chat));
      });
    }
  }

  void _onChatLoad(
    ChatLoad event,
    Emitter<ChatState> emit,
  ) {
    print('Chat is Loading');
    _chatSubscription =
        _databaseRepository.getChat(event.chatId!).listen((chat) {
      add(ChatUpdate(chat: chat));
    });
  }

  void _onChatAddMessage(
    ChatAddMessage event,
    Emitter<ChatState> emit,
  ) {
    if (state is ChatLoaded) {
      final state = this.state as ChatLoaded;
      print(event.text);

      final Message message = Message(
        senderId: event.userId,
        receiverId: event.matchedUserId,
        message: event.text,
        dateTime: DateTime.now(),
        timeString: DateFormat("HH:mm").format(DateTime.now()),
      );

      print(message);

      _databaseRepository.addMessage(state.chat.id, message);
      emit(ChatLoaded(chat: state.chat));
    }
  }

  void _onChatUpdate(
    ChatUpdate event,
    Emitter<ChatState> emit,
  ) {
    print(event.chat);
    emit(ChatLoaded(chat: event.chat));
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
