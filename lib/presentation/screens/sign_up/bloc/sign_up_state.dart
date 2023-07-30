part of 'sign_up_bloc.dart';



class SignUpState extends Equatable {
  const SignUpState({
    this.signUpStatus = RequestStatus.idle,
    this.password = const EditText(),
    this.phone = const EditText(),
    this.signUpError,
  });

  final RequestStatus signUpStatus;
  final String? signUpError;
  final EditText password;
  final EditText phone;

  SignUpState copyWith({
    RequestStatus? signUpStatus,
    EditText? password,
    EditText? phone,
    String? signUpError,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      signUpError: signUpError ?? this.signUpError,
    );
  }

  @override
  List<Object?> get props => [signUpStatus, password, phone, signUpError];
}


