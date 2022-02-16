import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dating_app/models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<LoadUsersEvent>(_onLoadUsersEvent);
    on<SwipeLeftEvent>(_onSwipeLeftEvent);
    on<SwipeRightEvent>(_onSwipeRightEvent);
  }

  void _onLoadUsersEvent(
    LoadUsersEvent event,
    Emitter<SwipeState> emit,
  ) {
    emit(SwipeLoaded(users: event.users));
  }

  void _onSwipeLeftEvent(
    SwipeLeftEvent event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      try {
        emit(
          SwipeLoaded(
            users: List.from(state.users)..remove(event.user),
          ),
        );
      } catch (_) {}
    }
  }

  void _onSwipeRightEvent(
    SwipeRightEvent event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      try {
        emit(
          SwipeLoaded(
            users: List.from(state.users)..remove(event.user),
          ),
        );
      } catch (_) {}
    }
  }
}
