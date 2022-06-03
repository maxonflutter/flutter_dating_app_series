import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../models/match_model.dart';
import '../../repositories/repositories.dart';
import '../../widgets/widgets.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider<MatchBloc>(
        create: (context) => MatchBloc(
          databaseRepository: context.read<DatabaseRepository>(),
        )..add(
            LoadMatches(user: context.read<AuthBloc>().state.user!),
          ),
        child: MatchesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'MATCHES'),
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state is MatchLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MatchLoaded) {
            final inactiveMatches =
                state.matches.where((match) => match.chat == null).toList();
            final activeMatches =
                state.matches.where((match) => match.chat != null).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Likes',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    MatchesList(inactiveMatches: inactiveMatches),
                    Text(
                      'Your Chats',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    ChatsList(activeMatches: activeMatches),
                  ],
                ),
              ),
            );
          }
          if (state is MatchUnavailable) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No matches yet.',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    text: 'BACK TO SWIPING',
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    beginColor: Theme.of(context).accentColor,
                    endColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {
                      RepositoryProvider.of<AuthRepository>(context).signOut();
                    },
                    child: Center(
                      child: Text(
                        'Sign Out',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Something went wrong.'),
            );
          }
        },
      ),
    );
  }
}

class ChatsList extends StatelessWidget {
  const ChatsList({
    Key? key,
    required this.activeMatches,
  }) : super(key: key);

  final List<Match> activeMatches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: activeMatches.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/chat',
                arguments: activeMatches[index]);
          },
          child: Row(
            children: [
              UserImage.small(
                margin: const EdgeInsets.only(top: 10, right: 10),
                height: 70,
                width: 70,
                url: activeMatches[index].matchedUser.imageUrls[0],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeMatches[index].matchedUser.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 5),
                  Text(
                    activeMatches[index].chat![0].messages[0].message,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 5),
                  Text(
                    activeMatches[index].chat![0].messages[0].timeString,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class MatchesList extends StatelessWidget {
  const MatchesList({
    Key? key,
    required this.inactiveMatches,
  }) : super(key: key);

  final List<Match> inactiveMatches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: inactiveMatches.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: Column(
              children: [
                UserImage.small(
                  height: 70,
                  width: 70,
                  url: inactiveMatches[index].matchedUser.imageUrls[0],
                ),
                Text(
                  inactiveMatches[index].matchedUser.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
