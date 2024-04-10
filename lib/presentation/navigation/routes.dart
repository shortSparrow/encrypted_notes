import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/presentation/navigation/screens.dart';
import 'package:encrypted_notes/presentation/screens/auth/auth_screen.dart';
import 'package:encrypted_notes/presentation/screens/confirm_credentials/confirm_credentials.dart';
import 'package:encrypted_notes/presentation/screens/home/home_screen.dart';
import 'package:encrypted_notes/presentation/screens/modify_note/modify_note_screen.dart';
import 'package:encrypted_notes/presentation/screens/register_web_bio/register_web_bio.dart';
import 'package:encrypted_notes/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:encrypted_notes/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: AppScreens.home.path,
  routes: [
    GoRoute(
      path: AppScreens.home.path,
      name: AppScreens.home.name,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: AppScreens.sign_up.path,
      name: AppScreens.sign_up.name,
      builder: (context, state) => const SignUpScreenWrapperProvider(),
    ),
    GoRoute(
      path: AppScreens.sign_in.path,
      name: AppScreens.sign_in.name,
      builder: (context, state) => const SignInScreenWrapperProvider(),
    ),
    GoRoute(
      path: AppScreens.auth.path,
      name: AppScreens.auth.name,
      builder: (context, state) => const AuthScreenWrapperProvider(),
    ),
    GoRoute(
      path: AppScreens.confirm_credentials.path,
      name: AppScreens.confirm_credentials.name,
      builder: (context, state) => const ConfirmCredentials(),
    ),
    GoRoute(
      path: AppScreens.register_web_bio.path,
      name: AppScreens.register_web_bio.name,
      builder: (context, state) => const RegisterWebBiosWrapperProvider(),
    ),
    GoRoute(
      path: AppScreens.modifyNote.path,
      name: AppScreens.modifyNote.name,
      builder: (context, state) {
        // TODO add typed params
        return ModifyNoteScreen(
          mode: (state.extra as Map?)?['mode'] ?? ModifyNoteMode.add,
          noteId: (state.extra as Map?)?['noteId'],
        );
      },
    ),
  ],
  redirect: (context, state) {
    final isLogged =
        sl<AppStateSharedPreferencesRepository>().getAppState().isLogged;
    final deviceId = sl<UserLocalRepository>().getUser()?.deviceId;

    if (isLogged == false && deviceId == null) {
      if (state.matchedLocation == AppScreens.sign_in.path) {
        return AppScreens.sign_in.path;
      }

      return AppScreens.sign_up.path;
    }

    // for cases when refresh token was expired and user must enter login and password again
    if (isLogged == false && deviceId != null) {
      return AppScreens.confirm_credentials.path;
    }
  },
);
