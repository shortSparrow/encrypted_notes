import 'dart:convert';

import 'package:encrypted_notes/data/shared_preferences/user_state/user_state.dart';
import 'package:encrypted_notes/domain/usecases/notes/encypt_note_use_case.dart';
import 'package:encrypted_notes/injection.dart';
import 'package:encrypted_notes/theme.dart';
import 'package:flutter/material.dart';
import 'package:encrypted_notes/injection.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'presentation/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(userStateBox);
  await di.init();
  await dotenv.load(fileName: ".env");

  final List<int> localTempSecretKey = jsonDecode(dotenv.env['localTempSecretKey'] ?? "").cast<int>();
  final EncryptNoteUseCase encryptNoteUseCase = sl();
  encryptNoteUseCase.setLocalSymmetricSecretKey(localTempSecretKey);

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
