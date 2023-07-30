part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}


class OnPasswordChange extends SignInEvent {
  const OnPasswordChange({required this.value});

  final String value;

  @override
  List<Object?> get props => [value];
}


class OnPhoneChange extends SignInEvent {
  const OnPhoneChange({required this.value});

  final String value;

  @override
  List<Object?> get props => [value];
}


class OnLogin extends SignInEvent {
  const OnLogin();

  @override
  List<Object?> get props => [];
}
