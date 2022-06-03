import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '/widgets/widgets.dart';
import '../../blocs/blocs.dart';
import '../../cubits/cubits.dart';
import '../../repositories/repositories.dart';
import 'onboarding_screens/screens.dart';
import 'widgets/widgets.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              storageRepository: context.read<StorageRepository>(),
              locationRepository: context.read<LocationRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: OnboardingScreen(),
      ),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Demographics'),
    Tab(text: 'Pictures'),
    Tab(text: 'Biography'),
    Tab(text: 'Location'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;

          context
              .read<OnboardingBloc>()
              .add(StartOnboarding(tabController: tabController));

          return Scaffold(
            appBar: CustomAppBar(
              title: 'ARROW',
              hasActions: false,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 50,
              ),
              child: BlocBuilder<OnboardingBloc, OnboardingState>(
                builder: (context, state) {
                  if (state is OnboardingLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is OnboardingLoaded) {
                    return TabBarView(
                      children: [
                        StartTab(state: state),
                        EmailTab(state: state),
                        DemoTab(state: state),
                        PicturesTab(state: state),
                        BioTab(state: state),
                        LocationTab(state: state),
                      ],
                    );
                  } else {
                    return Text('Something went wrong.');
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class OnboardingScreenLayout extends StatelessWidget {
  final List<Widget> children;
  final int currentStep;
  final void Function()? onPressed;

  const OnboardingScreenLayout({
    Key? key,
    required this.children,
    required this.currentStep,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...children,
                  Spacer(),
                  SizedBox(
                    height: 75,
                    child: Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 6,
                          currentStep: currentStep,
                          selectedColor: Theme.of(context).primaryColor,
                          unselectedColor: Theme.of(context).backgroundColor,
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          text: 'NEXT STEP',
                          onPressed: onPressed,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
