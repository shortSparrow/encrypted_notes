import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:encrypted_notes/presentation/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/AuthHeader.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/EnterCredentials.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreenWrapperProvider extends StatelessWidget {
  const SignUpScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpCubit>(),
      child: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpCubit = BlocProvider.of<SignUpCubit>(context);

    AppBar appBar = AppBar();
    var topOffset =
        appBar.preferredSize.height + MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Stack(children: [
        BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.runtimeType == SignUpSuccess) {
              if (kIsWeb) {
                context.go(AppScreens.register_web_bio.path);
              } else {
                context.go(AppScreens.home.path);
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: topOffset,
            ),
            child: Column(
              children: [
                const AuthHeader(),
                const Expanded(
                  child: EnterCredentials(
                    requestType: RequestType.signUp,
                  ),
                ),
                Button(text: "Sign Up", onPressed: signUpCubit.signUp),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case SignUpLoading:
                return Container(
                  foregroundDecoration:
                      const BoxDecoration(color: Colors.black26),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ]),
    );
  }
}
