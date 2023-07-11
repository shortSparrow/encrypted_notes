import 'package:encrypted_notes/presentation/screens/LoginScreen.dart';
import 'package:encrypted_notes/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.getTheme(),
      home:  Scaffold(
          appBar: AppBar(
            // title: const Text("Encrypted notes"),
          ),
          body: const LoginScreen(),
          ),
    );
  }
}
