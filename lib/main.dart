import 'dart:convert';

import 'package:encrypted_notes/data/shared_preferences/user_state/user_state.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/theme.dart';
import 'package:flutter/material.dart';
import 'package:encrypted_notes/injection.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'presentation/navigation/routes.dart';

const secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(userStateBox);
  await di.init();
  await dotenv.load(fileName: ".env");

  final List<int> localTempSecretKey =
      jsonDecode(dotenv.env['localTempSecretKey'] ?? "").cast<int>();
  final SecretSharedPreferencesRepository secretSharedPreferencesRepository =
      sl();
  secretSharedPreferencesRepository.setLocalSymmetricKey(localTempSecretKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme.getTheme(),
    );
  }
}
