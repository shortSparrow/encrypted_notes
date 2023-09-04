import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes.g.dart';

part 'notes.freezed.dart';

@freezed
class SyncedDevice with _$SyncedDevice {
  const factory SyncedDevice({
    required String deviceId,
    required bool isSynced,
  }) = _SyncedDevice;

  factory SyncedDevice.fromJson(Map<String, dynamic> json) =>
      _$SyncedDeviceFromJson(json);
}

@freezed
class Note with _$Note {
  const factory Note({
    required String title,
    required String message,
    required String createdAt,
    required String updatedAt,
    required int id,
    String? globalId,
    required List<SyncedDevice> syncedDevices,
  }) = _Note;
}

@freezed
class NoteDataForServer with _$NoteDataForServer {
  const factory NoteDataForServer({
    required String title,
    required String message,
    required String createdAt,
    required String updatedAt,
    required String sendToDevice,
    int? globalId,
  }) = _NoteDataForServer;
}
