import 'package:flutter/material.dart';
import 'package:flutter_dating_app/models/models.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChatScreen(userMatch: userMatch),
    );
  }

  final UserMatch userMatch;

  const ChatScreen({required this.userMatch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        title: Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                userMatch.matchedUser.imageUrls[0],
              ),
            ),
            Text(
              userMatch.matchedUser.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 10),
          ],
        ),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: userMatch.chat != null
                  ? Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: userMatch.chat![0].messages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: userMatch
                                        .chat![0].messages[index].senderId ==
                                    1
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                      child: Text(
                                        userMatch
                                            .chat![0].messages[index].message,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: NetworkImage(
                                            userMatch.matchedUser.imageUrls[0],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        ConstrainedBox(
                                          constraints:
                                              BoxConstraints(maxWidth: 250),
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            child: Text(
                                              userMatch.chat![0].messages[index]
                                                  .message,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: Colors.white),
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            subtitle:
                                userMatch.chat![0].messages[index].senderId == 1
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          userMatch.chat![0].messages[index]
                                              .timeString,
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          userMatch.chat![0].messages[index]
                                              .timeString,
                                        ),
                                      ),
                          );
                        },
                      ),
                    )
                  : SizedBox(),
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.send_outlined,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {}),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Type here ...',
                      contentPadding: const EdgeInsets.only(
                          left: 20.0, bottom: 5.0, top: 5.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
