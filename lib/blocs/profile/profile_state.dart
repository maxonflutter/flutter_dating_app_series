part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final bool isEditingOn;
  final GoogleMapController? controller;

  const ProfileLoaded({
    required this.user,
    this.isEditingOn = false,
    this.controller,
  });

  @override
  List<Object?> get props => [user, isEditingOn, controller];
}
