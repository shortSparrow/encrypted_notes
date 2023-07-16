import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/screens/cubit/login_cubit.dart';

import '../../injection.dart';
import '../core/widgets/AppIconButton.dart';

class LoginScreenWrapperProvider extends StatelessWidget {
  const LoginScreenWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _showBiometricsButton = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginCubit>(context).checkIfBiometricsAvailable();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 60),
          SizedBox(
            height: 40,
            child: Center(
              child: BlocListener<LoginCubit, LoginState>(
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
                    onPressed: loginCubit.callBiometricAuth,
                    svgIconPath: "assets/images/touchId.svg",
                    iconSize: const Size(20.0, 20.0),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Button(text: "Login", onPressed: loginCubit.onPressLogin),
        ],
      ),
    );
  }
}
