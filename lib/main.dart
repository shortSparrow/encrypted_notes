import 'dart:convert';

import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/TestEncryptionUseCase.dart';
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
  await Hive.openBox(HiveBoxes.userStateBox);
  await Hive.openBox(HiveBoxes.userBox);
  await di.init();
  await dotenv.load(fileName: ".env");

// TODO test login

  // try {
  //   final SecretSharedPreferencesRepository secretSharedPreferencesRepository =
  //       sl();
  //   final UserLocalRepository userLocalRepository = sl();
  //   final MessageEncryptionUseCase messageEncryptionUseCase = sl();

  //   final user = userLocalRepository.getUser();
  //   print("user: ${user}");

  //   final getKeyPair = await secretSharedPreferencesRepository.getE2EKeyPair();
  //   print("getKeyPair: ${getKeyPair}");

  //   final localSymmetricKey =
  //       await secretSharedPreferencesRepository.getLocalSymmetricKey();
  //   print("localSymmetricKey: ${localSymmetricKey}");
  // } catch (e) {
  //   print("e: ${e}");
  // }

  // try {
  //   final SecretSharedPreferencesRepository secretSharedPreferencesRepository =
  //       sl();
  //   final UserLocalRepository userLocalRepository = sl();
  //   final MessageEncryptionUseCase messageEncryptionUseCase = sl();
  //   await userLocalRepository.setUser(
  //       const User(id: '1', phone: '11111111', token: 'xyz', bioWedId: null));

  //   final keypair = await messageEncryptionUseCase.generateNewE2EKeyPair();
  //   final local = await messageEncryptionUseCase.generateNewLocalSymmetricKey();

  //   await secretSharedPreferencesRepository.setE2EKeyPair(keypair);
  //   await secretSharedPreferencesRepository.setLocalSymmetricKey(local);

  //   final getKeyPair = await secretSharedPreferencesRepository.getE2EKeyPair();
  //   print("getKeyPair: ${getKeyPair}");

  //   final localSymmetricKey =
  //       await secretSharedPreferencesRepository.getLocalSymmetricKey();
  //   print("localSymmetricKey: ${localSymmetricKey}");
  // } catch (e) {
  //   print("e: ${e}");
  // }

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
