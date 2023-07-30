import 'package:encrypted_notes/domain/models/request_status.dart';
import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/AuthHeader.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/EnterCredentials.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:encrypted_notes/presentation/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:go_router/go_router.dart';

class SingUpBody extends StatelessWidget {
  const SingUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthHeader(),
        BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.signUpStatus == RequestStatus.success) {
              if (kIsWeb) {
                context.go(AppScreens.register_web_bio.path);
              } else {
                context.go(AppScreens.home.path);
              }
            }
          },
          builder: (context, state) {
            final phoneErrorMessage =
                context.watch<SignUpBloc>().state.phone.validation.errorMessage;
            final passwordErrorMessage = context
                .watch<SignUpBloc>()
                .state
                .password
                .validation
                .errorMessage;

            final isLoading = state.signUpStatus == RequestStatus.loading;

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
                          requestType: RequestType.signUp,
                          onPasswordInput: (value) {
                            context
                                .read<SignUpBloc>()
                                .add(OnPasswordChange(value: value));
                          },
                          onPhoneInput: (value) {
                            context
                                .read<SignUpBloc>()
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
                    text: "Sign Up",
                    onPressed: () {
                      context.read<SignUpBloc>().add(const OnRegister());
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
