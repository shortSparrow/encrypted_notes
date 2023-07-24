import 'package:get_it/get_it.dart';

import 'data/repositories/bio_web_auth/bio_web_auth_repository_impl.dart';
import 'domain/repositories/bio_auth_repository.dart';
import 'domain/usecases/biometrics/biometric_auth_usease.dart';
import 'presentation/screens/login/cubit/login_cubit.dart';

final sl = GetIt.I; // sl == Service Locator

Future<void> init() async {
  // ** presentation layer
  // Factory = every time a new/fresh instance of a class
  // sl() - check if adviceUseCase exist in sl and if exist add it as parameter

  // ** domain layer
  sl.registerSingleton<BioAuthRepository>(BioWebAuthRepositoryImpl());

  sl.registerFactory<BiometricAuthUseCase>(
    () => BiometricAuthUseCase(bioAuthRepository: sl()),
  );

  sl.registerFactory<LoginCubit>(
    () => LoginCubit(getAvailableBiometricsUseCase: sl()),
  );
  // ** data layer

  // ** externs
}
