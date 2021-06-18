import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ChatScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'CHAT'),
      body: Container(),
    );
  }
}
