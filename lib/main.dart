import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:drift/drift.dart';
import 'package:encrypted_notes/constants/storage_keys.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/remote/apiClient.dart';
import 'package:encrypted_notes/data/remote/token_service.dart';
import 'package:encrypted_notes/data/repositories/shared_preferences/shared_preferences_repository_impl.dart';
import 'package:encrypted_notes/domain/models/notes/notes.dart';
import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/domain/usecases/encryption/message_encryption_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/TestEncryptionUseCase.dart';
import 'package:encrypted_notes/domain/usecases/notes/delete_failed_remote_deleted_notes_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/get_user_remote_devices.dart';
import 'package:encrypted_notes/domain/usecases/notes/get_synced_device_list.dart';
import 'package:encrypted_notes/extensions/ColorExtension.dart';
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

  final SharedPreferencesRepository sharedPreferencesRepositoryImpl = sl();
  setupApiClientInterceptors();

  if (sharedPreferencesRepositoryImpl.getUserState().isLogged) {
    final TokenService tokenService = sl();
    final GetUserRemoteDevicesUseCase getUserDevicesUseCase = sl();
    final DeleteFailedRemoteDeletedNotesUseCase
        deleteFailedRemoteDeletedNotesUseCase = sl();

    await tokenService.checkTokensExpiration();
    tokenService.setHTTPAuthorizationAccessToken();

    getUserDevicesUseCase.updateRemoteDevicesLocalData();
    deleteFailedRemoteDeletedNotesUseCase.deleteAllFailedDeletedNotes();
  }

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

  // try {
  //   final RemoteDeviceRepositoryLocal remoteDeviceRepositoryLocal = sl();

  //   await remoteDeviceRepositoryLocal.addRemoteDevice(
  //     RemoteDevicesCompanion(
  //       id: Value("device_1"),
  //       deviceName: Value("local test device 1"),
  //       systemVersion: Value("1"),
  //       devicePublicKey: Value(devicePublicKey_1.toJsonString()),
  //     ),
  //   );

  //   await remoteDeviceRepositoryLocal.addRemoteDevice(
  //     RemoteDevicesCompanion(
  //       id: Value("device_2"),
  //       deviceName: Value("local test device 2"),
  //       systemVersion: Value("1"),
  //       devicePublicKey: Value(devicePublicKey_2.toJsonString()),
  //     ),
  //   );

  //   await remoteDeviceRepositoryLocal.addRemoteDevice(
  //     RemoteDevicesCompanion(
  //       id: Value("device_3"),
  //       deviceName: Value("local test device 3"),
  //       systemVersion: Value("1"),
  //       devicePublicKey: Value(devicePublicKey_3.toJsonString()),
  //     ),
  //   );
  // } catch (e) {
  //   print("e: ${e}");
  // }

  // try {
  //   final GetAllUserDevicesUseCase getAllUserDevicesUseCase = sl();
  //   await getAllUserDevicesUseCase.getAllUserDevices();
  // } catch (e) {

  // }

  runApp(const MyApp());
  // runApp(const SizedBox());
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
