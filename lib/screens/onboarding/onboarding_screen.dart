import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../cubits/cubits.dart';
import '../../repositories/repositories.dart';
import '/widgets/widgets.dart';
import 'onboarding_screens/screens.dart';

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
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;

        context
            .read<OnboardingBloc>()
            .add(StartOnboarding(tabController: tabController));

        return Scaffold(
          appBar: CustomAppBar(
            title: 'ARROW',
            hasActions: false,
          ),
          body: TabBarView(
            children: [
              StartTab(),
              EmailTab(),
              DemoTab(),
              PicturesTab(),
              BioTab(),
              LocationTab(),
            ],
          ),
        );
      }),
    );
  }
}
