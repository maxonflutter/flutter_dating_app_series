import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final bool hasGradient;
  final Color? color;
  final IconData icon;

  const ChoiceButton({
    Key? key,
    this.width = 60,
    this.height = 60,
    this.size = 25,
    this.hasGradient = false,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: hasGradient
            ? LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 4,
            offset: Offset(3, 3),
          ),
        ],
      ),
    );
  }
}
