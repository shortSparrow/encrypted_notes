part of 'register_web_bio_cubit.dart';

abstract class RegisterWebBioState extends Equatable {
  const RegisterWebBioState();

  @override
  List<Object> get props => [];
}

class RegisterWebBioInitial extends RegisterWebBioState {}
class RegisterWebBioAvailable extends RegisterWebBioState {}
class RegisterWebBioNotAvailable extends RegisterWebBioState {}
