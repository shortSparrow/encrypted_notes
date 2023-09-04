import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_entity.freezed.dart';

@freezed
class BiometricEntity with _$BiometricEntity {
  const factory BiometricEntity({
    required bool isFaceIdSupported,
    required bool isTouchIdSupported,
  }) = _BiometricEntity;
}
