import 'package:equatable/equatable.dart';

class BiometricEntity extends Equatable {
  final bool isFaceIdSupported;
  final bool isTouchIdSupported;
  const BiometricEntity(
      {required this.isFaceIdSupported, required this.isTouchIdSupported});

  @override
  List<Object?> get props => [isFaceIdSupported, isTouchIdSupported];
}
