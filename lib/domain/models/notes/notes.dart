import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes.freezed.dart';
part 'notes.g.dart';

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
class DecryptedNote with _$DecryptedNote {
  const factory DecryptedNote({
    required String title,
    // Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
    required String message,
    required String createdAt,
    required String updatedAt,
    required int id,
    required String? noteGlobalId,
    required List<SyncedDevice> syncedDevices,
  }) = _Note;
}

@freezed
class EncryptedNote with _$EncryptedNote {
  const factory EncryptedNote({
    required String title,
    // Note stored into encryption DB, and when we get it message still encrypted by E2E (only when isDecrypted = true message are ready for reading)
    required EncryptedMessage message,
    required String createdAt,
    required String updatedAt,
    required int id,
    required String? noteGlobalId,
    required List<SyncedDevice> syncedDevices,
  }) = _EncryptedNote;
}

@freezed
class NoteDataForServer with _$NoteDataForServer {
  const factory NoteDataForServer({
    required NoteDataForServerMetaData metaData,
    required NoteDataForServerEncryptedData data,
  }) = _NoteDataForServer;

  factory NoteDataForServer.fromJson(Map<String, dynamic> json) =>
      _$NoteDataForServerFromJson(json);
}

@freezed
class NoteDataForServerMetaData with _$NoteDataForServerMetaData {
  const factory NoteDataForServerMetaData({
    required String createdAt,
    required String updatedAt,
    required String sendToDeviceId,
    required String? noteGlobalId,
  }) = _NoteDataForServerMetaData;

  factory NoteDataForServerMetaData.fromJson(Map<String, dynamic> json) =>
      _$NoteDataForServerMetaDataFromJson(json);
}

@freezed
class NoteDataForServerEncryptedData with _$NoteDataForServerEncryptedData {
  const factory NoteDataForServerEncryptedData({
    required EncryptedMessage title,
    required EncryptedMessage message,
  }) = _NoteDataForServerEncryptedData;

  factory NoteDataForServerEncryptedData.fromJson(Map<String, dynamic> json) =>
      _$NoteDataForServerEncryptedDataFromJson(json);
}

@freezed
class EncryptedMessage with _$EncryptedMessage {
  const factory EncryptedMessage({
    required List<int> cipherText,
    required List<int> nonce,
    required List<int> mac,
  }) = _EncryptedMessage;

  factory EncryptedMessage.fromJson(Map<String, dynamic> json) =>
      _$EncryptedMessageFromJson(json);
}

