import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/AuthHeader.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/EnterCredentials.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:encrypted_notes/presentation/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreenWrapperProvider extends StatelessWidget {
  const SignInScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignInCubit>(),
      child: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<SignInCubit>(context);
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SignInSuccess:
            context.go(AppScreens.home.path);
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
            top: 0,
          ),
          child: Column(
            children: [
              const AuthHeader(),
              const Expanded(
                child: EnterCredentials(
                  requestType: RequestType.login,
                ),
              ),
              BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case SignInLoading:
                      return Button(
                        childComponent: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        onPressed: () {
                          loginCubit.login('+38066', 'password');
                        },
                      );
                    default:
                      return Button(
                        text: "Login",
                        onPressed: () {
                          loginCubit.login('+38066', 'password');
                        },
                      );
                  }
                },
              ),
              // AppIconButton(icon: Icons.abc_sharp, onPressed: () {  },),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
