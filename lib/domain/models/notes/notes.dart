import 'package:cryptography/cryptography.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notes.freezed.dart';
part 'notes.g.dart';


// TODO find way to use freezed with own fromJson/toJson
// @freezed
class SyncedDevice {
  // const factory SyncedDevice({
  //   required String deviceId,
  //   required SimplePublicKey devicePublicKey,
  //   required bool isSynced,
  // }) = _SyncedDevice;

  // factory SyncedDevice.fromJson(Map<String, dynamic> json) =>
  //     _$SyncedDeviceFromJson(json);

  final String deviceId;
  final SimplePublicKey devicePublicKey;
  final bool isSynced;

  SyncedDevice({
    required this.deviceId,
    required this.devicePublicKey,
    required this.isSynced,
  });

  SyncedDevice copyWith({
    String? deviceId,
    SimplePublicKey? devicePublicKey,
    bool? isSynced,
  }) {
    return SyncedDevice(
      deviceId: deviceId ?? this.deviceId,
      devicePublicKey: devicePublicKey ?? this.devicePublicKey,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  factory SyncedDevice.fromJson(Map<String, dynamic> json) {
    final devicePublicKey = json['devicePublicKey'].cast<int>();

    return SyncedDevice(
      deviceId: json['deviceId'],
      isSynced: json['isSynced'],
      devicePublicKey: SimplePublicKey(
        devicePublicKey,
        type: KeyPairType.x25519,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "deviceId": deviceId,
      'isSynced': isSynced,
      'devicePublicKey': devicePublicKey.bytes,
    };
  }
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
    String? globalId,
    required List<SyncedDevice> syncedDevices,
  }) = _EncryptedNote;
}

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

// TODO probably delete because duplicate NoteDataForServerEncryptedData
@freezed
class NoteDataForServerData with _$NoteDataForServerData {
  const factory NoteDataForServerData({
    required EncryptedMessage title,
    required EncryptedMessage message,
  }) = _NoteDataForServerData;
}

@freezed
class NoteDataForServerEncryptedData with _$NoteDataForServerEncryptedData {
  const factory NoteDataForServerEncryptedData({
    required EncryptedMessage title,
    required EncryptedMessage message,
  }) = _NoteDataForServerEncryptedData;
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
