import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/swipe/swipe_bloc.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/users';

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => UsersScreen(user: user),
    );
  }

  final User user;

  const UsersScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.9,
            child: Stack(
              children: [
                Hero(
                  tag: 'user_card',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: UserImage.medium(
                      url: user.imageUrls[0],
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 60,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChoiceButton.small(
                          color: Theme.of(context).accentColor,
                          icon: Icons.clear_rounded,
                          onTap: () {
                            BlocProvider.of<SwipeBloc>(context)
                              ..add(
                                SwipeLeft(user: user),
                              );
                            print('Swiped Left');
                          },
                        ),
                        ChoiceButton.large(onTap: () {
                          BlocProvider.of<SwipeBloc>(context)
                            ..add(
                              SwipeRight(user: user),
                            );
                          print('Swiped Right');
                        }),
                        ChoiceButton.small(
                          color: Theme.of(context).primaryColor,
                          icon: Icons.watch_later,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}, ${user.age}',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  user.jobTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 15),
                Text(
                  'About',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(user.bio,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(height: 2)),
                SizedBox(height: 15),
                Text(
                  'Interests',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Row(
                  children: user.interests
                      .map((interest) => Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.only(top: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).accentColor,
                                ],
                              ),
                            ),
                            child: Text(
                              interest,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
