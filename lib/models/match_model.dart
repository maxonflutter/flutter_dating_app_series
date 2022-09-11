import 'package:equatable/equatable.dart';

import 'models.dart';

class Match extends Equatable {
  final String userId;
  final User matchedUser;
  final Chat chat;

  const Match({
    required this.userId,
    required this.matchedUser,
    required this.chat,
  });

  Match copyWith({
    String? userId,
    User? matchedUser,
    Chat? chat,
  }) {
    return Match(
      userId: userId ?? this.userId,
      matchedUser: matchedUser ?? this.matchedUser,
      chat: chat ?? this.chat,
    );
  }

  @override
  List<Object?> get props => [userId, matchedUser, chat];
}
