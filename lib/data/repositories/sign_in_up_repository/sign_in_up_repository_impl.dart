import 'package:encrypted_notes/domain/models/user/user.dart';
import 'package:encrypted_notes/domain/repositories/sign_in_up_repository.dart';

// TODO implement requiest with Dio
class SignInUpRepositoryImpl extends SignInUpRepository {
  @override
  Future<User>singIn(
    String deviceId,
    String phone,
    String password,
  ) async {
    // if response has 404 error or anyting els thtow this error
    await Future.delayed(const Duration(seconds: 2));
    return User(phone: phone, token: phone, bioWedId: null, id: '1'); // FIXME  or maybe nor null if user set it before (check the flow)
  }

  @override
  Future<User> signUp(
    String deviceId,
    String phone,
    String password,
  ) async {
    // if response has 404 error or anyting els thtow this error
    await Future.delayed(const Duration(seconds: 2));
    return User(phone: phone, token: password, bioWedId: null, id: '1');
  }
}
