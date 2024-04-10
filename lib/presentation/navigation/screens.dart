import 'package:encrypted_notes/domain/models/app_page/app_page.dart';

class AppScreens {
  static const auth = AppPage(name: 'auth', route: 'auth', path: '/auth');
  static const sign_in = AppPage(name: 'login', route: 'login', path: '/login');
  static const sign_up =
      AppPage(name: 'sign_up', route: 'sign_up', path: '/sign_up');
  static const confirm_credentials =
      AppPage(name: 'confirm_credentials', route: 'confirm_credentials', path: '/confirm_credentials');
  static const register_web_bio = AppPage(
    name: 'register_web_bio',
    route: 'register_web_bio',
    path: '/register_web_bio',
  );
  static const home = AppPage(name: 'home', route: '/', path: '/');
  static const modifyNote = AppPage(name: 'modify_note', route: 'modify_note', path: '/modify_note');
}
