import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../repositories/location/location_repository.dart';
import '../auth/auth_bloc.dart';
import '../../models/models.dart';
import '../../repositories/database/database_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  final LocationRepository _locationRepository;
  StreamSubscription? _authSubscription;

  ProfileBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
    required LocationRepository locationRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        _locationRepository = locationRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<EditProfile>(_onEditProfile);
    on<SaveProfile>(_onSaveProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<UpdateUserLocation>(_onUpdateUserLocation);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user is AuthUserChanged) {
        if (state.user != null) {
          print('Loading User Profile');
          add(LoadProfile(userId: state.authUser!.uid));
        }
      }
    });
  }

  void _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    User user = await _databaseRepository.getUser(event.userId).first;
    emit(ProfileLoaded(user: user));
  }

  void _onEditProfile(
    EditProfile event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      emit(
        ProfileLoaded(
          user: (state as ProfileLoaded).user,
          isEditingOn: event.isEditingOn,
          controller: (state as ProfileLoaded).controller,
        ),
      );
    }
  }

  void _onSaveProfile(
    SaveProfile event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      _databaseRepository.updateUser((state as ProfileLoaded).user);
      emit(
        ProfileLoaded(
          user: (state as ProfileLoaded).user,
          isEditingOn: false,
          controller: (state as ProfileLoaded).controller,
        ),
      );
    }
  }

  void _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      emit(
        ProfileLoaded(
          user: event.user,
          isEditingOn: (state as ProfileLoaded).isEditingOn,
          controller: (state as ProfileLoaded).controller,
        ),
      );
    }
  }

  void _onUpdateUserLocation(
    UpdateUserLocation event,
    Emitter<ProfileState> emit,
  ) async {
    final state = this.state as ProfileLoaded;

    if (event.isUpdateComplete && event.location != null) {
      print('Getting location with the Places API');
      final Location location =
          await _locationRepository.getLocation(event.location!.name);

      state.controller!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            location.lat.toDouble(),
            location.lon.toDouble(),
          ),
        ),
      );

      add(UpdateUserProfile(user: state.user.copyWith(location: location)));
    } else {
      emit(
        ProfileLoaded(
          user: state.user.copyWith(location: event.location),
          controller: event.controller ?? state.controller,
          isEditingOn: state.isEditingOn,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
