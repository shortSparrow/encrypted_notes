import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:encrypted_notes/injection.dart';

import 'bloc/sign_up_bloc.dart';
import 'widgets/sign_up_body.dart';

class SignUpScreenWrapperProvider extends StatelessWidget {
  const SignUpScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpBloc>(),
      child: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    var topOffset =
        appBar.preferredSize.height + MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: topOffset,
            ),
            child: const CustomScrollView(
              slivers: [
                SliverFillRemaining(hasScrollBody: false, child: SingUpBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
