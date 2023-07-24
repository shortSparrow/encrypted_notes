import 'package:encrypted_notes/theme.dart';
import 'package:flutter/material.dart';
import 'package:encrypted_notes/injection.dart' as di;

import 'presentation/screens/sign_up/SignUpScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.getTheme(),
      home: Scaffold(
        appBar: AppBar(),
        // body: const LoginScreenWrapperProvider(),
        body: const SignUpScreen(),
      ),
    );
  }
}
