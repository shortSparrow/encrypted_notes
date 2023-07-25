import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:encrypted_notes/presentation/screens/login/LoginScreen.dart';
import 'package:encrypted_notes/presentation/screens/sign_up/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppScreens.home.path,
      name: AppScreens.home.name,
      builder: (context, state) => const Center(child: Text("HOME")),
    ),
    GoRoute(
      path: AppScreens.sign_up.path,
      name: AppScreens.sign_up.name,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppScreens.login.path,
      name: AppScreens.login.name,
      builder: (context, state) => const LoginScreenWrapperProvider(),
    ),
  ],
  redirect: (context, state) {
    if (state.matchedLocation == AppScreens.login.path) {
      return AppScreens.login.path;
    }

    return AppScreens.sign_up.path;
  },
);
