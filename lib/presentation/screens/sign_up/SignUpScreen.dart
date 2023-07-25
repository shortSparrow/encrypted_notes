import 'package:flutter/material.dart';

import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/AuthHeader.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/EnterCredentials.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const AuthHeader(),
            const Expanded(
              child: EnterCredentials(
                requestType: RequestType.signUp,
              ),
            ),
            Button(text: "Sign Up", onPressed: () {}),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
