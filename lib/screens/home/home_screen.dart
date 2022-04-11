import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/screens.dart';
import '/blocs/blocs.dart';
import '/models/models.dart';
import '/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        print(BlocProvider.of<AuthBloc>(context).state.status);
        return BlocProvider.of<AuthBloc>(context).state.status ==
                AuthStatus.unauthenticated
            ? LoginScreen()
            : HomeScreen();
      },
    );
  }

  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoading) {
          return Scaffold(
            appBar: CustomAppBar(title: 'DISCOVER'),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SwipeLoaded) {
          print('Build SwipeLoaded');
          return SwipeLoadedHomeScreen(state: state);
        }
        if (state is SwipeMatched) {
          return SwipeMatchedHomeScreen(state: state);
        }
        if (state is SwipeError) {
          return Scaffold(
            appBar: CustomAppBar(title: 'DISCOVER'),
            body: Center(
              child: Text(
                'There aren\'t any more users.',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: CustomAppBar(title: 'DISCOVER'),
            body: Center(
              child: Text('Something went wrong.'),
            ),
          );
        }
      },
    );
  }
}

class SwipeMatchedHomeScreen extends StatelessWidget {
  const SwipeMatchedHomeScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SwipeMatched state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congrats, it\'s a match!',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 20),
            Text(
              'You and ${state.user.name} have liked each other!',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).accentColor,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                          context.read<AuthBloc>().state.user!.imageUrls[0]),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).accentColor,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(state.user.imageUrls[0]),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'SEND A MESSAGE',
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
              beginColor: Colors.white,
              endColor: Colors.white,
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'BACK TO SWIPING',
              textColor: Colors.white,
              onPressed: () {
                context.read<SwipeBloc>().add(
                      LoadUsers(
                        user: context.read<AuthBloc>().state.user,
                      ),
                    );
              },
              beginColor: Theme.of(context).accentColor,
              endColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class SwipeLoadedHomeScreen extends StatelessWidget {
  const SwipeLoadedHomeScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final SwipeLoaded state;

  @override
  Widget build(BuildContext context) {
    var userCount = state.users.length;
    return Scaffold(
      appBar: CustomAppBar(title: 'DISCOVER'),
      body: Column(
        children: [
          InkWell(
            onDoubleTap: () {
              Navigator.pushNamed(
                context,
                '/users',
                arguments: state.users[0],
              );
            },
            child: Draggable<User>(
              data: state.users[0],
              child: UserCard(user: state.users[0]),
              feedback: UserCard(user: state.users[0]),
              childWhenDragging: (userCount > 1)
                  ? UserCard(user: state.users[1])
                  : Container(),
              onDragEnd: (drag) {
                if (drag.velocity.pixelsPerSecond.dx < 0) {
                  context.read<SwipeBloc>()
                    ..add(SwipeLeft(user: state.users[0]));
                  print('Swiped Left');
                } else {
                  context.read<SwipeBloc>()
                    ..add(SwipeRight(user: state.users[0]));
                  print('Swiped Right');
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceButton.small(
                color: Theme.of(context).accentColor,
                icon: Icons.clear_rounded,
                onTap: () {
                  context.read<SwipeBloc>()
                    ..add(
                      SwipeRight(user: state.users[0]),
                    );
                },
              ),
              ChoiceButton.large(
                onTap: () {
                  context.read<SwipeBloc>()
                    ..add(
                      SwipeRight(user: state.users[0]),
                    );
                },
              ),
              ChoiceButton.small(
                color: Theme.of(context).primaryColor,
                icon: Icons.watch_later,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
