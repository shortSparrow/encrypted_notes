import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/TextButton.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create your account or",
                      style: theme.textTheme.titleMedium,
                    ),
                    LinkedButton(
                      text: "login",
                      onTap: () {},
                    )
                  ],
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'phone number',
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'password',
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          Button(text: "Next", onPressed: () {}),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
