import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:encrypted_notes/domain/failures/failures.dart';
import 'package:encrypted_notes/domain/usecases/auth/sign_in_up_usecase.dart';
import 'package:encrypted_notes/presentation/core/widgets/snackbar.dart';

SnackbarProps getSnackbarMessageForLoginError(
  AppError<ReLoginErrorCodes> error,
) {
  switch (error.code) {
    case ReLoginErrorCodes.unexpected:
      return SnackbarProps(
        title: "Unexpected error happens during login",
        message: "Please, try login later",
        contentType: ContentType.failure,
      );
    case ReLoginErrorCodes.deviceIdNull:
      return SnackbarProps(
        title: "Imposable confirm your identity",
        message: "Please, login again",
        contentType: ContentType.warning,
      );
    case ReLoginErrorCodes.network:
      return SnackbarProps(
        title: "Failed confirm your identity",
        message: error.message,
        contentType: ContentType.failure,
      );
  }
}
