import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIconButton extends StatelessWidget {
  final IconData? icon;
  final String? svgIconPath;
  final Size? iconSize;
  final void Function() onPressed;
  const AppIconButton(
      {super.key,
      required this.onPressed,
      this.icon,
      this.svgIconPath,
      this.iconSize});

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
        child: svgIconPath is String
            ? SvgPicture.asset(
                svgIconPath as String,
                width: iconSize?.width,
                height: iconSize?.height,
              )
            : icon is IconData
                ? Icon(
                    icon,
                    size: iconSize?.width,
                  )
                : null,
      ),
    );
  }
}
