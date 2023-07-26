import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? text;
  final Widget? childComponent;
  final void Function() onPressed;
  const Button({
    super.key,
    this.text,
    required this.onPressed,
    this.childComponent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 1.5, color: theme.primaryColor),
        foregroundColor: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: childComponent ??
            Text(
              text ?? '',
              style: TextStyle(color: theme.primaryColor),
            ),
      ),
    );
  }
}
