import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/TextButton.dart';
import 'package:encrypted_notes/presentation/core/widgets/auth/EnterCredentials.dart';
import 'package:encrypted_notes/presentation/screens/confirm_credentials/confirm_credentials_model.dart';
import 'package:encrypted_notes/presentation/screens/confirm_credentials/widgets/confirm_credentials_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmCredentials extends StatelessWidget {
  const ConfirmCredentials({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<ConfirmCredentialsModel>(),
      child: const ConfirmCredentialsContent(),
    );
  }
}

class ConfirmCredentialsContent extends StatelessWidget {
  const ConfirmCredentialsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ConfirmCredentialsModel>(context, listen: false);

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
            top: 0,
          ),
          child: Consumer<ConfirmCredentialsModel>(builder: (
            BuildContext context,
            ConfirmCredentialsModel value,
            Widget? child,
          ) {
            return Column(
              children: [
                const ConfirmCredentialsHeader(),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EnterCredentials(
                      requestType: RequestType.login,
                      onPasswordInput: provider.onPasswordChanged,
                      onPhoneInput: provider.onPhoneChanged,
                      passwordErrorMessage:
                          provider.uiState.passwordErrorMessage,
                      phoneErrorMessage: provider.uiState.phoneErrorMessage,
                    ),
                  ],
                )),
                const SizedBox(height: 50),
                Button(
                  text: "Login",
                  onPressed: () {
                    provider.login();
                  },
                  isEnabled: !provider.uiState.isLoginButtonDisable,
                  isLoading: provider.uiState.isLoadingLogin,
                ),
                const SizedBox(height: 20),
                LinkedButton(
                  text: "Logout",
                  onTap: () {
                    provider.logout();
                  },
                ),
              ],
            );
          })),
    );
  }
}
