import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/repositories/modify_note/modify_note_local_repository.dart';
import 'package:encrypted_notes/data/repositories/shared_preferences_repository/shared_preferences_repository_impl.dart';
import 'package:encrypted_notes/data/repositories/sign_in_up_repository/sign_in_up_repository_impl.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/usecases/notes/add_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/sign_in_up/sign_in_up_usecase.dart';
import 'package:encrypted_notes/presentation/screens/auth/cubit/auth_cubit.dart';
import 'package:encrypted_notes/presentation/screens/home/bloc/note_bloc.dart';
import 'package:encrypted_notes/presentation/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:encrypted_notes/utils/generate_device_id/generate_device_id.dart';
import 'package:get_it/get_it.dart';

import 'data/database/dao/notes_dao.dart';
import 'data/repositories/bio_web_auth/bio_web_auth_repository_impl.dart';
import 'data/repositories/modify_note/modify_note_remote_repository.dart';
import 'domain/repositories/bio_auth_repository.dart';
import 'domain/repositories/modify_note_local_repository.dart';
import 'domain/repositories/sign_in_up_repository.dart';
import 'domain/usecases/biometrics/biometric_auth_usease.dart';
import 'domain/usecases/notes/load_notes_use_case.dart';
import 'presentation/screens/register_web_bio/cubit/register_web_bio_cubit.dart';
import 'presentation/screens/sign_in/bloc/sign_in_bloc.dart';

final sl = GetIt.I; // sl == Service Locator

Future<void> init() async {
  // Factory = every time a new/fresh instance of a class
  // sl() - check if adviceUseCase exist in sl and if exist add it as parameter

  // **************** PRESENTATION LAYER
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(getAvailableBiometricsUseCase: sl()),
  );

  sl.registerFactory<RegisterWebBioCubit>(
    () => RegisterWebBioCubit(getAvailableBiometricsUseCase: sl()),
  );

  sl.registerFactory<SignInBloc>(
    () => SignInBloc(signInUpUseCase: sl()),
  );

  sl.registerFactory<SignUpBloc>(
    () => SignUpBloc(signInUpUseCase: sl()),
  );

  sl.registerFactory<NoteBloc>(
    () => NoteBloc(loadNoteUseCase: sl(), addNoteUseCase: sl()),
  );

  // **************** DATA LAYER
  sl.registerSingleton<NotesDao>(AppDatabase.getInstance().notesDao);

  // **************** DOMAIN LAYER

  // ** repositories
  sl.registerSingleton<BioAuthRepository>(BioWebAuthRepositoryImpl());
  sl.registerSingleton<SignInUpRepository>(SignInUpRepositoryImpl());
  sl.registerSingleton<SharedPreferencesRepository>(
      SharedPreferencesRepositoryImpl());

  sl.registerSingleton<ModifyNoteLocalRepository>(
      ModifyNoteLocalRepositoryImpl(notesDao: sl()));

  sl.registerSingleton<ModifyNoteRemoteRepository>(
      ModifyNoteRemoteRepositoryImpl());

  // ** usecase
  sl.registerFactory<BiometricAuthUseCase>(
    () => BiometricAuthUseCase(
      bioAuthRepository: sl(),
      sharedPreferencesRepository: sl(),
    ),
  );

  sl.registerFactory<SignInUpUseCase>(
    () => SignInUpUseCase(
        signInUpRepository: sl(),
        generateDeviceId: sl(),
        sharedPreferencesRepository: sl()),
  );

  sl.registerFactory<LoadNoteUseCase>(
    () => LoadNoteUseCase(
      modifyNoteRepository: sl(),
      modifyNoteRemoteRepository: sl(),
    ),
  );

  sl.registerFactory<AddNoteUseCase>(
    () => AddNoteUseCase(
      modifyNoteLocalRepository: sl(),
      modifyNoteRemoteRepository: sl(),
    ),
  );

  // **************** UTILS
  sl.registerSingleton(GenerateDeviceId());
}
