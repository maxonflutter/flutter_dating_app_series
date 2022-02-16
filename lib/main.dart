import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/blocs.dart';
import '/config/app_router.dart';
import '/repositories/repositories.dart';
import '/screens/screens.dart';

import 'config/theme.dart';
import 'models/models.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (_) => SwipeBloc()
              ..add(
                LoadUsersEvent(
                  users: User.users.where((user) => user.id != 1).toList(),
                ),
              ),
          ),
          BlocProvider(
            create: (_) => ImagesBloc(
              databaseRepository: DatabaseRepository(),
            )..add(
                LoadImages(),
              ),
          ),
        ],
        child: MaterialApp(
          title: 'Dating App',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: OnboardingScreen.routeName,
        ),
      ),
    );
  }
}
