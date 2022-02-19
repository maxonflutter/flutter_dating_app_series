import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String text;
  final Function(bool?)? onChanged;

  const CustomCheckbox({
    Key? key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: onChanged,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.normal,
              ),
        ),
      ],
    );
  }
}
