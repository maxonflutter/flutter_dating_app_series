import 'package:flutter/material.dart';
import 'package:flutter_dating_app/models/models.dart';
import 'package:flutter_dating_app/widgets/widgets.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => MatchesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();

    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: CustomAppBar(title: 'MATCHES'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Likes',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: inactiveMatches.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        UserImageSmall(
                          url: inactiveMatches[index].matchedUser.imageUrls[0],
                          width: 70,
                          height: 70,
                        ),
                        Text(
                          inactiveMatches[index].matchedUser.name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your Chats',
                style: Theme.of(context).textTheme.headline4,
              ),
              ListView.builder(
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
                        UserImageSmall(
                          url: activeMatches[index].matchedUser.imageUrls[0],
                          width: 70,
                          height: 70,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeMatches[index].matchedUser.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(height: 5),
                              Text(
                                activeMatches[index]
                                    .chat![0]
                                    .messages[0]
                                    .message,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          activeMatches[index].chat![0].messages[0].timeString,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
