import 'package:flutter/material.dart';

class CheckboxWithText extends StatefulWidget {
  const CheckboxWithText({super.key, required this.text});
  final String text;

  @override
  State<CheckboxWithText> createState() => _CheckboxWithTextState();
}

class _CheckboxWithTextState extends State<CheckboxWithText> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (value) => setState(() {
            this.value = value!;
          }),
          activeColor: theme.secondary,
        ),
        Text(
          widget.text,
          style: TextStyle(
              color: theme.onSurface,
              fontSize: 13.0,
              fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
