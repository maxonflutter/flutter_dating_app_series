import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;
  final bool centerTitle;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.hasActions = true,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, '/');
              },
              child: Container(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 50,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
      actions: hasActions
          ? [
              IconButton(
                  icon: Icon(Icons.message,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, '/matches');
                  }),
              IconButton(
                  icon:
                      Icon(Icons.person, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  })
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
