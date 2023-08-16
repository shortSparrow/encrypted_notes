import 'package:encrypted_notes/domain/models/app_page.dart';

class AppScreens {
  static final auth = AppPage(name: 'auth', route: 'auth', path: '/auth');
  static final sign_in = AppPage(name: 'login', route: 'login', path: '/login');
  static final sign_up =
      AppPage(name: 'sign_up', route: 'sign_up', path: '/sign_up');
  static final register_web_bio = AppPage(
    name: 'register_web_bio',
    route: 'register_web_bio',
    path: '/register_web_bio',
  );
  static final home = AppPage(name: 'home', route: '/', path: '/');
  static final modifyNote = AppPage(name: 'modify_note', route: 'modify_note', path: '/modify_note');
}
