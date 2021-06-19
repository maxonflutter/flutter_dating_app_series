import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dating_app/blocs/swipe/swipe_bloc.dart';
import 'package:flutter_dating_app/config/app_router.dart';
import 'package:flutter_dating_app/screens/screens.dart';

import 'config/theme.dart';
import 'models/models.dart';
import 'screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SwipeBloc()
            ..add(
              LoadUsersEvent(
                users: User.users.where((user) => user.id != 1).toList(),
              ),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Dating App',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: MatchesScreen.routeName,
      ),
    );
  }
}
