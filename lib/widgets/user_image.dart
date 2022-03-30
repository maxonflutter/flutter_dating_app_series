import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String? url;
  final double height;
  final double width;
  final EdgeInsets? margin;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final Widget? child;

  const UserImage.small({
    Key? key,
    this.url,
    this.height = 60,
    this.width = 60,
    this.margin,
    this.boxShadow,
    this.border,
    this.child,
  }) : super(key: key);

  const UserImage.medium({
    Key? key,
    this.url,
    this.height = 200,
    this.width = double.infinity,
    this.margin,
    this.boxShadow,
    this.border,
    this.child,
  }) : super(key: key);

  const UserImage.large({
    Key? key,
    this.url,
    this.height = double.infinity,
    this.width = double.infinity,
    this.margin,
    this.boxShadow,
    this.border,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: (url == null)
                ? AssetImage('assets/placeholder-image.png') as ImageProvider
                : NetworkImage(url!)),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: border,
        boxShadow: boxShadow,
        color: Theme.of(context).primaryColor,
      ),
      child: child,
    );
  }
}




// const [
//         const BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 4,
//           blurRadius: 4,
//           offset: Offset(3, 3),
//         )