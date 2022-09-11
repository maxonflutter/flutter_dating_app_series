import 'package:equatable/equatable.dart';

import 'models.dart';

class Match extends Equatable {
  final String userId;
  final User matchUser;
  final Chat chat;

  const Match({
    required this.userId,
    required this.matchUser,
    required this.chat,
  });

  Match copyWith({
    String? userId,
    User? matchUser,
    Chat? chat,
  }) {
    return Match(
      userId: userId ?? this.userId,
      matchUser: matchUser ?? this.matchUser,
      chat: chat ?? this.chat,
    );
  }

  @override
  List<Object?> get props => [userId, matchUser, chat];
}
