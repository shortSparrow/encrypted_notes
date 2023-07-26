part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailed extends SignInState {
  final String reason;
  const SignInFailed({required this.reason});

  @override
  List<Object> get props => [reason];
}
