part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class OnPasswordChange extends SignUpEvent {
  const OnPasswordChange({required this.value});

  final String value;

  @override
  List<Object> get props => [value];
}


class OnPhoneChange extends SignUpEvent {
  const OnPhoneChange({required this.value});

  final String value;

  @override
  List<Object> get props => [value];
}


class OnRegister extends SignUpEvent {
  const OnRegister();

  @override
  List<Object> get props => [];
}
