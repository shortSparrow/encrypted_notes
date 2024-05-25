import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:encrypted_notes/main.dart';
import 'package:flutter/material.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class SnackbarProps {
  final String title;
  final String message;
  final ContentType contentType;

  SnackbarProps({
    required this.title,
    this.message = "",
    required this.contentType,
  });
}

enum SnackbarType { large, standard }

enum SnackbarDuration { short, long, extraLong, infinity }

ScaffoldMessengerState openSnackbar({
  required String title,
  required String message,
  required ContentType contentType,
  bool isFloating = false,
  SnackbarType type = SnackbarType.large,
  SnackbarDuration duration = SnackbarDuration.short,
}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    backgroundColor: Colors.transparent,
    clipBehavior: isFloating ? Clip.antiAlias : Clip.none,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
    ),
    padding: isFloating
        ? const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20)
        : const EdgeInsets.all(10),
    duration: getSnackbarDuration(duration),
  );

  return scaffoldMessengerKey.currentState!
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

Duration getSnackbarDuration(SnackbarDuration duration) {
  switch (duration) {
    case SnackbarDuration.short:
      return const Duration(seconds: 2);
    case SnackbarDuration.long:
      return const Duration(seconds: 4);
    case SnackbarDuration.extraLong:
      return const Duration(seconds: 10);
    case SnackbarDuration.infinity:
      return const Duration(days: 1);
  }
}
