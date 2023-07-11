import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:flutter/material.dart';

import '../core/widgets/AppIconButton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Password',
            ),
             obscureText: true,
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIconButton(
                onPressed: () {},
                svgIconPath: "assets/images/faceId.svg",
                iconSize: const Size(20.0, 20.0),
              ),
              const SizedBox(width: 100),
              AppIconButton(
                onPressed: () {},
                svgIconPath: "assets/images/touchId.svg",
                iconSize: const Size(20.0, 20.0),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Button(text: "Login", onPressed: () {}),
        ],
      ),
    );
  }
}
