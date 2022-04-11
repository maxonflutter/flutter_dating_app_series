part of 'match_bloc.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class LoadMatches extends MatchEvent {
  final User user;

  const LoadMatches({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdateMatches extends MatchEvent {
  final List<Match> matchedUsers;

  const UpdateMatches({required this.matchedUsers});

  @override
  List<Object> get props => [matchedUsers];
}
