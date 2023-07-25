import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          "Welcome to encrypted notes",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Text(
          "present on any platform",
          style: theme.textTheme.titleSmall,
        ),
      ],
    );
  }
}
