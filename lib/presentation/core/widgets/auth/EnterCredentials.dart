import 'package:encrypted_notes/presentation/core/widgets/TextButton.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RequestType { login, signUp }

class EnterCredentials extends StatelessWidget {
  final RequestType requestType;
  const EnterCredentials({super.key, required this.requestType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: requestType == RequestType.signUp
              ? [
                  Text(
                    "Create your account or",
                    style: theme.textTheme.titleMedium,
                  ),
                  LinkedButton(
                    text: "login",
                    onTap: () {
                      context.push(AppScreens.sign_in.path);
                    },
                  )
                ]
              : [
                  Text(
                    "Login to your account",
                    style: theme.textTheme.titleMedium,
                  ),
                ],
        ),
        const SizedBox(height: 30),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'phone number',
            ),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
        ),
        const SizedBox(height: 30),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'password',
            ),
            obscureText: true,
          ),
        )
      ],
    );
  }
}
