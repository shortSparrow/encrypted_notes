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
    // Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
    required String message,
    required String createdAt,
    required String updatedAt,
    required int id,
    String? globalId,
    required List<SyncedDevice> syncedDevices,
    @Default(false) bool isDecrypted,
  }) = _Note;
}

// @freezed
// class NoteDataForServer with _$NoteDataForServer {
//   const factory NoteDataForServer({
//     required String title,
//     required String message,
//     required String createdAt,
//     required String updatedAt,
//     required String sendToDevice,
//     int? globalId,
//   }) = _NoteDataForServer;
// }

@freezed
class NoteDataForServer with _$NoteDataForServer {
  const factory NoteDataForServer({
    required NoteDataForServerMetaData metaData,
    required NoteDataForServerData data,
  }) = _NoteDataForServer;
}

@freezed
class NoteDataForServerMetaData with _$NoteDataForServerMetaData {
  const factory NoteDataForServerMetaData({
    required String createdAt,
    required String updatedAt,
    required String sendToDevice,
    int? globalId,
  }) = _NoteDataForServerMetaData;
}

@freezed
class NoteDataForServerData with _$NoteDataForServerData {
  const factory NoteDataForServerData({
    required String title,
    required String message,
  }) = _NoteDataForServerData;
}
