import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/AuthHeader.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/EnterCredentials.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:encrypted_notes/presentation/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SingInBody extends StatelessWidget {
  const SingInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthHeader(),
        BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state.signInStatus == RequestStatus.success) {
              context.go(AppScreens.home.path);
            }
            if (state.signInStatus == RequestStatus.failed) {
              final errorMessage = state.signUpError;
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog error'),
                  content:  Text("${errorMessage}"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            final phoneErrorMessage =
                context.watch<SignInBloc>().state.phone.validation.errorMessage;
            final passwordErrorMessage = context
                .watch<SignInBloc>()
                .state
                .password
                .validation
                .errorMessage;

            final isLoading = state.signInStatus == RequestStatus.loading;

            final loginDisable = phoneErrorMessage != null ||
                passwordErrorMessage != null ||
                state.phone.value.isEmpty ||
                state.password.value.isEmpty ||
                isLoading;

            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EnterCredentials(
                          requestType: RequestType.login,
                          onPasswordInput: (value) {
                            context
                                .read<SignInBloc>()
                                .add(OnPasswordChange(value: value));
                          },
                          onPhoneInput: (value) {
                            context
                                .read<SignInBloc>()
                                .add(OnPhoneChange(value: value));
                          },
                          passwordErrorMessage: passwordErrorMessage,
                          phoneErrorMessage: phoneErrorMessage,
                          isTextFieldDisabled: isLoading,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Button(
                    text: "Login",
                    onPressed: () {
                      context.read<SignInBloc>().add(const OnLogin());
                    },
                    isEnabled: !loginDisable,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
