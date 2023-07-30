part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.signInStatus = RequestStatus.idle,
    this.password = const EditText(),
    this.phone = const EditText(),
    this.signUpError,
  });

  final RequestStatus signInStatus;
  final String? signUpError;
  final EditText password;
  final EditText phone;

  SignInState copyWith({
    RequestStatus? signInStatus,
    EditText? password,
    EditText? phone,
    String? signUpError,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      signUpError: signUpError ?? this.signUpError,
    );
  }

  @override
  List<Object?> get props => [signInStatus, password, phone, signUpError];
}
