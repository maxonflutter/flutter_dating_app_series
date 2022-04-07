import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String text;
  final bool value;
  final Function(bool?)? onChanged;

  const CustomCheckbox({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
