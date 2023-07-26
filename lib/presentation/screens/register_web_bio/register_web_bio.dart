import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/core/widgets/Button.dart';
import 'package:encrypted_notes/presentation/core/widgets/TextButton.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:encrypted_notes/presentation/screens/register_web_bio/cubit/register_web_bio_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterWebBiosWrapperProvider extends StatelessWidget {
  const RegisterWebBiosWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterWebBioCubit>(),
      child: const RegisterWebBios(),
    );
  }
}

class RegisterWebBios extends StatefulWidget {
  const RegisterWebBios({super.key});

  @override
  State<RegisterWebBios> createState() => _RegisterWebBiosState();
}

class _RegisterWebBiosState extends State<RegisterWebBios> {
  @override
  void initState() {
    BlocProvider.of<RegisterWebBioCubit>(context).checkIfBiometricsAvailable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: BlocListener<RegisterWebBioCubit, RegisterWebBioState>(
          listener: (context, state) {
            if (state.runtimeType == RegisterWebBioNotAvailable) {
              context.go(AppScreens.home.path);
            }
          },
          child: BlocBuilder<RegisterWebBioCubit, RegisterWebBioState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case RegisterWebBioAvailable:
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "You logged in successful",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: Text(
                            "Your device support biometric access. Would you like to add finger print to fast access?",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Button(text: "add", onPressed: () {}),
                        const SizedBox(height: 90),
                        LinkedButton(
                          text: 'skip for now',
                          onTap: () {
                            context.go(AppScreens.home.path);
                          },
                        )
                      ],
                    ),
                  );
                case RegisterWebBioInitial:
                  return const Center(child: CircularProgressIndicator());
                default:
                  return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
