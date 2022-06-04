import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dating_app/blocs/auth/auth_bloc.dart';

import '/models/models.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';
  final Match match;

  const ChatScreen({
    Key? key,
    required this.match,
  }) : super(key: key);

  static Route route({required Match match}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChatScreen(match: match),
    );
  }

  @override
  Widget build(BuildContext context) {
    var messagesCount = (match.chat == null) ? 0 : match.chat!.messages.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(match.matchedUser.imageUrls[0]),
            ),
            Text(
              match.matchedUser.name,
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: messagesCount,
            itemBuilder: (context, index) {
              return ListTile(
                title: _Message(
                  message: match.chat!.messages[index].message,
                  isFromCurrentUser: match.chat!.messages[index].senderId ==
                      context.read<AuthBloc>().state.authUser!.uid,
                ),
              );
            },
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 100,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send_outlined),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Type here...',
                      contentPadding:
                          const EdgeInsets.only(left: 20, bottom: 5, top: 5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
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

class _Message extends StatelessWidget {
  const _Message({
    Key? key,
    required this.message,
    required this.isFromCurrentUser,
  }) : super(key: key);

  final String message;
  final bool isFromCurrentUser;

  @override
  Widget build(BuildContext context) {
    AlignmentGeometry alignment =
        isFromCurrentUser ? Alignment.topRight : Alignment.topLeft;
    Color color = isFromCurrentUser
        ? Theme.of(context).backgroundColor
        : Theme.of(context).primaryColor;
    TextStyle? textStyle = isFromCurrentUser
        ? Theme.of(context).textTheme.headline6
        : Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white,
            );

    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: color,
        ),
        child: Text(
          message,
          style: textStyle,
        ),
      ),
    );
  }
}
