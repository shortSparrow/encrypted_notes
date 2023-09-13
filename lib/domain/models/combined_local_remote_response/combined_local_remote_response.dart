import 'package:freezed_annotation/freezed_annotation.dart';

// part 'combined_local_remote_response.freezed.dart';

// @freezed
// class CombinedLocalRemoteResponse<Local, Remote> with _$CombinedLocalRemoteResponse{
//   const factory CombinedLocalRemoteResponse({required Remote remote, required Local local}) = _CombinedLocalRemoteResponse;
// }

class CombinedLocalRemoteResponse<Local, Remote> {
  final Remote remote;
  final Local local;
  CombinedLocalRemoteResponse({required this.remote, required this.local});
}
