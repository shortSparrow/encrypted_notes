import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? text;
  final Widget? childComponent;
  final void Function() onPressed;
  final bool isEnabled;
  final bool isLoading;

  const Button({
    super.key,
    this.text,
    required this.onPressed,
    this.childComponent,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textComponent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        isLoading
            ?  Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.grey[300],
                  ),
                ),
              )
            : const SizedBox(),
        Text(
          text ?? '',
          style: TextStyle(
            color: isEnabled ? theme.primaryColor : Colors.grey[300],
          ),
        )
      ],
    );

    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: isEnabled
          ? OutlinedButton.styleFrom(
              side: BorderSide(width: 1.5, color: theme.primaryColor),
              foregroundColor: Colors.black,
            )
          : OutlinedButton.styleFrom(
              side: BorderSide(width: 1.5, color: Colors.grey[300]!),
              foregroundColor: Colors.white,
            ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10, horizontal: isLoading ? 10 : 15),
        child: childComponent ?? textComponent,
      ),
    );
  }
}
