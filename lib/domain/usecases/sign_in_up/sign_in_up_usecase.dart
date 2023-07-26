import 'package:dartz/dartz.dart';
import 'package:encrypted_notes/domain/entities/user.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/repositories/sign_in_up_repository.dart';
import 'package:encrypted_notes/utils/generate_device_id/generate_device_id.dart';

class SignInUpUseCase {
  final SignInUpRepository signInUpRepository;
  final GenerateDeviceId generateDeviceId;

  SignInUpUseCase({
    required this.signInUpRepository,
    required this.generateDeviceId,
  });

  Future<Either<Failure, User>> signUp(String phone, String password) async {
    try {
      final deviceId = await generateDeviceId.getDeviceId();
      return signInUpRepository.signUp(deviceId, phone, password);
    } catch (e) {
      // TODO handle error
      return left(GeneralFailure(message: 'add error handling'));
    }
  }

  Future<Either<Failure, User>> login(String phone, String password) async {
    try {
      final deviceId = await generateDeviceId.getDeviceId();
      final result = await signInUpRepository.singIn(deviceId, phone, password);
      return result;
    } catch (e) {
      // TODO handle error
      return left(GeneralFailure(message: 'add error handling'));
    }
  }
}
