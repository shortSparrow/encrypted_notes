import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:encrypted_notes/domain/usecases/sign_in_up/sign_in_up_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUpUseCase signInUseCase;
  SignInCubit({required this.signInUseCase}) : super(SignInInitial());

  Future login(String phone, String password) async {
    emit(SignInLoading());
    final result = await signInUseCase.login(phone, password);
    result.fold(
      (failure) {
        emit(SignInFailed(reason: "add reason"));
      },
      (user) {
        emit(SignInSuccess());
      },
    );
  }
}
