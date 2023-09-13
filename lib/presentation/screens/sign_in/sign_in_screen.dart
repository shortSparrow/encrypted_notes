import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:encrypted_notes/presentation/screens/sign_in/widgets/sing_in_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreenWrapperProvider extends StatelessWidget {
  const SignInScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignInBloc>(),
      child: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final loginCubit = BlocProvider.of<SignInCubit>(context);
    // return BlocListener<SignInCubit, SignInState>(
    //   listener: (context, state) {
    //     switch (state.runtimeType) {
    //       case SignInSuccess:
    //         context.go(AppScreens.home.path);
    //         break;
    //       default:
    //     }
    //   },
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
          top: 0,
        ),
        child: SingInBody(),
      ),
    );
  }
}
