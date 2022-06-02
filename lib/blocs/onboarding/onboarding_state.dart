part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final User user;
  final TabController tabController;
  final GoogleMapController? mapController;

  OnboardingLoaded({
    required this.user,
    required this.tabController,
    this.mapController,
  });

  @override
  List<Object?> get props => [user, tabController, mapController];
}
