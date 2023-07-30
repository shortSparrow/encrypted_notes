import 'package:encrypted_notes/presentation/core/widgets/TextButton.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum RequestType { login, signUp }

// errorStyle and errorBorder must be set manually because on the web, when Input takes an error style and onHover occurs, the bottom border and text become transparent
class EnterCredentials extends StatelessWidget {
  final RequestType requestType;
  final Function(String value) onPhoneInput;
  final Function(String value) onPasswordInput;
  final String? phoneErrorMessage;
  final String? passwordErrorMessage;
  final bool isTextFieldDisabled;

  const EnterCredentials({
    super.key,
    required this.requestType,
    required this.onPhoneInput,
    required this.onPasswordInput,
    this.phoneErrorMessage,
    this.passwordErrorMessage,
    this.isTextFieldDisabled = false,
  });

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
        Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
              child: TextFormField(
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'phone number',
                  errorText: phoneErrorMessage,
                  errorStyle: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onChanged: onPhoneInput,
                enabled: !isTextFieldDisabled,
              ),
            ),
            const SizedBox(height: 30),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
              child: TextFormField(
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'password',
                  errorText: passwordErrorMessage,
                         errorStyle: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.error),
                  ),
                ),
                obscureText: true,
                onChanged: onPasswordInput,
                enabled: !isTextFieldDisabled,
              ),
            )
          ],
        ),
      ],
    );
  }
}
