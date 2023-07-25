import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:encrypted_notes/presentation/core/widgets/Button.dart';

import '../../../injection.dart';
import '../../core/widgets/AppIconButton.dart';
import 'cubit/auth_cubit.dart';

class AuthScreenWrapperProvider extends StatelessWidget {
  const AuthScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _showBiometricsButton = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkIfBiometricsAvailable();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              height: 40,
              child: Center(
                child: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoginHasBiometricAbility) {
                      // without setState animation don't applies
                      setState(() {
                        _showBiometricsButton = true;
                      });
                    } else {
                      setState(() {
                        _showBiometricsButton = false;
                      });
                    }
                  },
                  child: AnimatedOpacity(
                    opacity: _showBiometricsButton ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 2000),
                    child: AppIconButton(
                      onPressed: authCubit.callBiometricAuth,
                      svgIconPath: "assets/images/touchId.svg",
                      iconSize: const Size(20.0, 20.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Button(text: "Login", onPressed: authCubit.onPressLogin),
          ],
        ),
      ),
    );
  }
}
