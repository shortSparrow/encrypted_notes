import 'package:encrypted_notes/constants/AppColors.dart';
import 'package:flutter/material.dart';

class LinkedButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const LinkedButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 6,
        ),
        child: Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
