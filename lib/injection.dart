import 'package:encrypted_notes/data/database/dao/failed_deleted_notes.dart';
import 'package:encrypted_notes/data/database/dao/remote_device_dao.dart';
import 'package:encrypted_notes/data/database/database.dart';
import 'package:encrypted_notes/data/mapper/remote_device_mapper.dart';
import 'package:encrypted_notes/data/remote/token_service.dart';
import 'package:encrypted_notes/data/repositories/modify_note/modify_note_local_repository.dart';
import 'package:encrypted_notes/data/repositories/remote_device_repository/remote_device_repository_local_impl.dart';
import 'package:encrypted_notes/data/repositories/remote_device_repository/remote_device_repository_remote_impl.dart';
import 'package:encrypted_notes/data/repositories/shared_preferences/secret_shared_preferences_repository_impl.dart';
import 'package:encrypted_notes/data/repositories/shared_preferences/shared_preferences_repository_impl.dart';
import 'package:encrypted_notes/data/repositories/sign_in_up_repository/sign_in_up_repository_impl.dart';
import 'package:encrypted_notes/data/repositories/user_local_repository/user_local_repository.dart';
import 'package:encrypted_notes/domain/repositories/modify_note_remote_repository.dart';
import 'package:encrypted_notes/domain/repositories/secret_shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_local.dart';
import 'package:encrypted_notes/domain/repositories/synced_client_repository_remote.dart';
import 'package:encrypted_notes/domain/repositories/user_local_repository.dart';
import 'package:encrypted_notes/domain/usecases/auth/logout_usecase.dart';
import 'package:encrypted_notes/domain/usecases/notes/TestEncryptionUseCase.dart';
import 'package:encrypted_notes/domain/usecases/notes/add_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/delete_failed_remote_deleted_notes_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/delete_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/edit_note_use_case.dart';
import 'package:encrypted_notes/domain/usecases/notes/get_user_remote_devices.dart';
import 'package:encrypted_notes/domain/usecases/notes/get_synced_device_list.dart';
import 'package:encrypted_notes/domain/usecases/auth/sign_in_up_usecase.dart';
import 'package:encrypted_notes/presentation/screens/auth/cubit/auth_cubit.dart';
import 'package:encrypted_notes/presentation/screens/confirm_credentials/confirm_credentials_model.dart';
import 'package:encrypted_notes/presentation/screens/home/bloc/home_bloc.dart';
import 'package:encrypted_notes/presentation/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:encrypted_notes/utils/generate_device_id/generate_device_id.dart';
import 'package:get_it/get_it.dart';

import 'data/database/dao/notes_dao.dart';
import 'data/mapper/notes_mapper.dart';
import 'data/repositories/bio_web_auth/bio_web_auth_repository_impl.dart';
import 'data/repositories/modify_note/modify_note_remote_repository.dart';
import 'domain/repositories/bio_auth_repository.dart';
import 'domain/repositories/modify_note_local_repository.dart';
import 'domain/repositories/sign_in_up_repository.dart';
import 'domain/usecases/biometrics/biometric_auth_usease.dart';
import 'domain/usecases/encryption/message_encryption_use_case.dart';
import 'domain/usecases/notes/load_notes_use_case.dart';
import 'presentation/screens/modify_note/bloc/modify_note_bloc.dart';
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

  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      loadNoteUseCase: sl(),
      logoutUsecase: sl(),
    ),
  );

  sl.registerFactory<ModifyNoteBloc>(
    () => ModifyNoteBloc(
      addNoteUseCase: sl(),
      loadNoteUseCase: sl(),
      editNoteUseCase: sl(),
      deleteNoteUseCase: sl(),
    ),
  );
  sl.registerFactory<ConfirmCredentialsModel>(
    () => ConfirmCredentialsModel(
      signInUpUseCase: sl(),
      logoutUsecase: sl(),
    ),
  );

  // **************** DATA LAYER
  sl.registerSingleton<NotesDao>(AppDatabase.getInstance().notesDao);
  sl.registerSingleton<RemoteDevicesDao>(
    AppDatabase.getInstance().remoteDevicesDao,
  );
  sl.registerSingleton<FailedDeletedNotesDao>(
    AppDatabase.getInstance().failedDeletedNotesDao,
  );

  // **************** DOMAIN LAYER

  // ** repositories
  sl.registerSingleton<BioAuthRepository>(BioWebAuthRepositoryImpl());
  sl.registerSingleton<SignInUpRepository>(SignInUpRepositoryImpl());
  sl.registerSingleton<AppStateSharedPreferencesRepository>(
      AppStateSharedPreferencesRepositoryImpl());

  sl.registerSingleton<ModifyNoteLocalRepository>(ModifyNoteLocalRepositoryImpl(
    notesDao: sl(),
    failedDeletedNotesDao: sl(),
  ));

  sl.registerSingleton<ModifyNoteRemoteRepository>(
      ModifyNoteRemoteRepositoryImpl());

  sl.registerSingleton<UserLocalRepository>(UserLocalRepositoryImpl());

  sl.registerFactory<SecretSharedPreferencesRepository>(
    () => SecretSharedPreferencesRepositoryImpl(userLocalRepository: sl()),
  );

  sl.registerFactory<RemoteDeviceRepositoryLocal>(
    () => RemoteDeviceRepositoryLocalImpl(
        remoteDeviceMapper: sl(), remoteDevicesDao: sl()),
  );

  sl.registerFactory<RemoteDeviceRepositoryRemote>(
    () => RemoteDeviceRepositoryImpl(),
  );

  // ** usecase
  sl.registerFactory<BiometricAuthUseCase>(
    () => BiometricAuthUseCase(
      bioAuthRepository: sl(),
      secretSharedPreferencesRepository: sl(),
      sharedPreferencesRepository: sl(),
    ),
  );

  sl.registerFactory<SignInUpUseCase>(
    () => SignInUpUseCase(
      signInUpRepository: sl(),
      generateDeviceId: sl(),
      sharedPreferencesRepository: sl(),
      messageEncryptionUseCase: sl(),
      secretSharedPreferencesRepository: sl(),
      userLocalRepository: sl(),
      remoteDeviceRepositoryLocal: sl(),
      tokenService: sl(),
    ),
  );
  // TODO remove
  sl.registerFactory<TestEncryptionUseCase>(
    () => TestEncryptionUseCase(
      getSyncedDeviceListUseCase: sl(),
      notesMapper: sl(),
      getE2EKeyPairForNotesUseCase: sl(),
      secretSharedPreferencesRepository: sl(),
      messageEncryptionUseCase: sl(),
    ),
  );

  sl.registerFactory<LoadNoteUseCase>(
    () => LoadNoteUseCase(
      modifyNoteRepository: sl(),
      modifyNoteRemoteRepository: sl(),
      notesMapper: sl(),
      secretSharedPreferencesRepository: sl(),
      messageEncryptionUseCase: sl(),
      remoteDeviceRepositoryLocal: sl(),
    ),
  );

  sl.registerFactory<AddNoteUseCase>(
    () => AddNoteUseCase(
      modifyNoteLocalRepository: sl(),
      modifyNoteRemoteRepository: sl(),
      notesMapper: sl(),
      messageEncryptionUseCase: sl(),
      secretSharedPreferencesRepository: sl(),
      remoteDeviceRepositoryLocal: sl(),
      getUserDevicesUseCase: sl(),
    ),
  );

  sl.registerFactory<EditNoteUseCase>(
    () => EditNoteUseCase(
      modifyNoteLocalRepository: sl(),
      modifyNoteRemoteRepository: sl(),
      notesMapper: sl(),
      secretSharedPreferencesRepository: sl(),
      messageEncryptionUseCase: sl(),
      remoteDeviceRepositoryLocal: sl(),
    ),
  );

  sl.registerFactory<MessageEncryptionUseCase>(
    () => MessageEncryptionUseCase(secretSharedPreferencesRepository: sl()),
  );

  sl.registerFactory<GetSyncedDeviceListUseCase>(
    () => GetSyncedDeviceListUseCase(),
  );

  sl.registerFactory<GetUserRemoteDevicesUseCase>(
    () => GetUserRemoteDevicesUseCase(
      remoteDeviceRepositoryRemote: sl(),
      remoteDeviceRepositoryLocal: sl(),
    ),
  );

  sl.registerFactory<DeleteNoteUseCase>(
    () => DeleteNoteUseCase(
      modifyNoteLocalRepository: sl(),
      modifyNoteRemoteRepository: sl(),
    ),
  );

  sl.registerFactory<DeleteFailedRemoteDeletedNotesUseCase>(
    () => DeleteFailedRemoteDeletedNotesUseCase(
      modifyNoteLocalRepository: sl(),
      modifyNoteRemoteRepository: sl(),
    ),
  );

  sl.registerFactory<LogoutUsecase>(
    () => LogoutUsecase(
      sharedPreferencesRepository: sl(),
      userLocalRepository: sl(),
      secretSharedPreferencesRepository: sl(),
      signInUpRepository: sl(),
    ),
  );

  // **************** UTILS
  sl.registerSingleton(GenerateDeviceId());
  sl.registerSingleton(NotesMapper());
  sl.registerSingleton(RemoteDeviceMapper());
  sl.registerSingleton(
    TokenService(
      logoutUsecase: sl(),
      secretSharedPreferencesRepository: sl(),
    ),
  );
}
