import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/widgets.dart';
import '/blocs/blocs.dart';
import '/repositories/repositories.dart';
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
      builder: (context) => BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(
          databaseRepository: context.read<DatabaseRepository>(),
        )..add(LoadChat(match.chat.id)),
        child: ChatScreen(match: match),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _CustomAppBar(match: match),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatDeleted) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ChatLoaded) {
            return Column(
              children: [
                ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: state.chat.messages.length,
                  itemBuilder: (context, index) {
                    List<Message> messages = state.chat.messages;
                    return ListTile(
                      title: _Message(
                        message: messages[index].message,
                        isFromCurrentUser: messages[index].senderId ==
                            context.read<AuthBloc>().state.authUser!.uid,
                      ),
                    );
                  },
                ),
                Spacer(),
                _MessageInput(match: match)
              ],
            );
          }
          if (state is ChatDeleted) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'The chat has been deleted.',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    text: 'BACK TO MATCHES',
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    beginColor: Theme.of(context).accentColor,
                    endColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            );
          } else {
            return Text('Something went wrong.');
          }
        },
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({
    Key? key,
    required this.match,
  }) : super(key: key);

  final Match match;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Container(
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
              onPressed: () {
                context.read<ChatBloc>()
                  ..add(
                    AddMessage(
                      userId: match.userId,
                      matchUserId: match.matchUser.id!,
                      message: controller.text,
                    ),
                  );
                controller.clear();
              },
              color: Colors.white,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
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

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({
    Key? key,
    required this.match,
  }) : super(key: key);

  final Match match;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      title: Column(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(match.matchUser.imageUrls[0]),
          ),
          Text(
            match.matchUser.name,
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: ((context) {
                return Container(
                  height: 100,
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        context.read<ChatBloc>()
                          ..add(
                            DeleteChat(
                              userId: match.userId,
                              matchUserId: match.matchUser.id!,
                            ),
                          );
                        Navigator.pop(context);
                      },
                      child: Text('Delete Match'),
                    ),
                  ),
                );
              }),
            );
          },
          icon: Icon(Icons.more_vert),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
