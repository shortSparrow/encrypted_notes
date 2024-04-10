import 'package:flutter/material.dart';

class ConfirmCredentialsHeader extends StatelessWidget {
  const ConfirmCredentialsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          "You access was expired",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Text(
          "please, enter you credentials for continue use app",
          style: theme.textTheme.titleSmall,
        ),
      ],
    );
  }
}
