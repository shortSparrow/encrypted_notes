import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_page.freezed.dart';

@freezed
class AppPage with _$AppPage {
  const factory AppPage({
    required String name,
    required String route,
    required String path,
  }) = _AppPage;
}
