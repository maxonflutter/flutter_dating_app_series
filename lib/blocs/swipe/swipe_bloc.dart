import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '/blocs/blocs.dart';
import '/models/models.dart';
import '/repositories/repositories.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _authSubscription;

  SwipeBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateHome>(_onUpdateHome);
    on<SwipeLeft>(_onSwipeLeft);
    on<SwipeRight>(_onSwipeRight);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user is AuthUserChanged) {
        if (state.user!.uid != null) {
          add(LoadUsers(userId: state.user!.uid));
        }
      }
    });
  }

  void _onLoadUsers(
    LoadUsers event,
    Emitter<SwipeState> emit,
  ) {
    _databaseRepository.getUsers(event.userId).listen((users) {
      add(
        UpdateHome(users: users),
      );
    });
  }

  void _onUpdateHome(
    UpdateHome event,
    Emitter<SwipeState> emit,
  ) {
    emit(SwipeLoaded(users: event.users));
  }

  void _onSwipeLeft(
    SwipeLeft event,
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

  void _onSwipeRight(
    SwipeRight event,
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

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
