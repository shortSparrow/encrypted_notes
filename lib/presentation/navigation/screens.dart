

import 'package:encrypted_notes/domain/entities/app_page.dart';

class AppScreens {
  static final login = AppPage(name: 'login', route: 'login', path: '/login');
  static final sign_up =
      AppPage(name: 'sign_up', route: 'sign_up', path: '/sign_up');
  static final home = AppPage(name: 'home', route: '/', path: '/');
}