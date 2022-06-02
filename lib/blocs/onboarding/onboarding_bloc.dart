import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '/models/models.dart';
import '/repositories/repositories.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final DatabaseRepository _databaseRepository;
  final StorageRepository _storageRepository;
  final LocationRepository _locationRepository;

  OnboardingBloc({
    required DatabaseRepository databaseRepository,
    required StorageRepository storageRepository,
    required LocationRepository locationRepository,
  })  : _databaseRepository = databaseRepository,
        _storageRepository = storageRepository,
        _locationRepository = locationRepository,
        super(OnboardingLoading()) {
    on<StartOnboarding>(_onStartOnboarding);
    on<ContinueOnboarding>(_onContinueOnboarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
    on<SetUserLocation>(_onSetUserLocation);
  }

  void _onStartOnboarding(
    StartOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(
      OnboardingLoaded(
        user: User.empty,
        tabController: event.tabController,
      ),
    );
  }

  void _onContinueOnboarding(
    ContinueOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final state = this.state as OnboardingLoaded;

    if (event.isSignup) {
      await _databaseRepository.createUser(event.user);
    }

    state.tabController.animateTo(state.tabController.index + 1);

    emit(
      OnboardingLoaded(
        user: event.user,
        tabController: state.tabController,
      ),
    );
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<OnboardingState> emit,
  ) {
    if (state is OnboardingLoaded) {
      _databaseRepository.updateUser(event.user);
      emit(
        OnboardingLoaded(
            user: event.user,
            tabController: (state as OnboardingLoaded).tabController),
      );
    }
  }

  void _onUpdateUserImages(
    UpdateUserImages event,
    Emitter<OnboardingState> emit,
  ) async {
    if (state is OnboardingLoaded) {
      User user = (state as OnboardingLoaded).user;
      await _storageRepository.uploadImage(user, event.image);

      _databaseRepository.getUser(user.id!).listen((user) {
        add(UpdateUser(user: user));
      });
    }
  }

  void _onSetUserLocation(
    SetUserLocation event,
    Emitter<OnboardingState> emit,
  ) async {
    final state = this.state as OnboardingLoaded;

    if (event.isUpdateComplete && event.location != null) {
      print('Getting location with the Places API');
      final Location location =
          await _locationRepository.getLocation(event.location!.name);

      state.mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            location.lat.toDouble(),
            location.lon.toDouble(),
          ),
        ),
      );

      _databaseRepository.getUser(state.user.id!).listen((user) {
        add(UpdateUser(user: state.user.copyWith(location: location)));
      });
    } else {
      emit(
        OnboardingLoaded(
          user: state.user.copyWith(location: event.location),
          mapController: event.controller ?? state.mapController,
          tabController: state.tabController,
        ),
      );
    }
  }
}
