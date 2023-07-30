import 'package:encrypted_notes/data/repositories/shared_preferences_repository/shared_preferences_repository_impl.dart';
import 'package:encrypted_notes/data/repositories/sign_in_up_repository/sign_in_up_repository_impl.dart';
import 'package:encrypted_notes/domain/repositories/shared_preferences_repository.dart';
import 'package:encrypted_notes/domain/usecases/sign_in_up/sign_in_up_usecase.dart';
import 'package:encrypted_notes/presentation/screens/auth/cubit/auth_cubit.dart';
import 'package:encrypted_notes/presentation/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:encrypted_notes/utils/generate_device_id/generate_device_id.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/bio_web_auth/bio_web_auth_repository_impl.dart';
import 'domain/repositories/bio_auth_repository.dart';
import 'domain/repositories/sign_in_up_repository.dart';
import 'domain/usecases/biometrics/biometric_auth_usease.dart';
import 'presentation/screens/register_web_bio/cubit/register_web_bio_cubit.dart';
import 'presentation/screens/sign_in/cubit/sign_in_cubit.dart';

final sl = GetIt.I; // sl == Service Locator

Future<void> init() async {
  // ** presentation layer
  // Factory = every time a new/fresh instance of a class
  // sl() - check if adviceUseCase exist in sl and if exist add it as parameter

  // ** domain layer
  sl.registerSingleton<BioAuthRepository>(BioWebAuthRepositoryImpl());
  sl.registerSingleton<SignInUpRepository>(SignInUpRepositoryImpl());
  sl.registerSingleton<SharedPreferencesRepository>(SharedPreferencesRepositoryImpl());

  sl.registerFactory<BiometricAuthUseCase>(
    () => BiometricAuthUseCase(bioAuthRepository: sl(), sharedPreferencesRepository: sl()),
  );

  sl.registerFactory<SignInUpUseCase>(
    () => SignInUpUseCase(signInUpRepository: sl(), generateDeviceId: sl(), sharedPreferencesRepository: sl()),
  );

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(getAvailableBiometricsUseCase: sl()),
  );

  sl.registerFactory<SignUpCubit>(
    () => SignUpCubit(signInUseCase: sl()),
  );

  sl.registerFactory<RegisterWebBioCubit>(
    () => RegisterWebBioCubit(getAvailableBiometricsUseCase: sl()),
  );

  sl.registerFactory<SignInCubit>(
    () => SignInCubit(signInUseCase: sl()),
  );
  // ** data layer

  // ** externs

  // ** utils
  sl.registerSingleton(GenerateDeviceId());
}
