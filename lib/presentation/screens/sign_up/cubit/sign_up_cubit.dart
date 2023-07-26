import 'package:encrypted_notes/domain/usecases/sign_in_up/sign_in_up_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignInUpUseCase signInUseCase;
  SignUpCubit({required this.signInUseCase}) : super(SignUpInitial());

  Future signUp() async {
    emit(SignUpLoading());
    final result = await signInUseCase.signUp('+38066', 'pass');
    
    result.fold(
      (failure) => {emit(const SignUpFailed(reason: 'xxx'))},
      (user) {
        emit(SignUpSuccess());
      },
    );
  }
}
