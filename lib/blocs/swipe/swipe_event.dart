part of 'swipe_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends SwipeEvent {
  final String userId;

  LoadUsers({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class UpdateHome extends SwipeEvent {
  final List<User>? users;

  UpdateHome({
    required this.users,
  });

  @override
  List<Object?> get props => [users];
}

class SwipeLeft extends SwipeEvent {
  final User user;

  SwipeLeft({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class SwipeRight extends SwipeEvent {
  final User user;

  SwipeRight({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}
