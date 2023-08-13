import 'package:equatable/equatable.dart';

class SyncedDevice {
  final String deviceId;
  final bool isSynced;

  Map toJson() => {
        'deviceId': deviceId,
        'isSynced': isSynced,
      };

  factory SyncedDevice.fromJson(Map<String, dynamic> json) {
    return SyncedDevice(deviceId: json['deviceId'], isSynced: json['isSynced']);
  }

  SyncedDevice({required this.deviceId, required this.isSynced});
}

class Note extends Equatable {
  final String message;
  final String createdAt;
  final String updatedAt;
  final int id;
  final String? globalId;
  final List<SyncedDevice> syncedDevices;

  const Note({
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.globalId,
    required this.syncedDevices,
  });

  Note copyWith({
    String? message,
    String? createdAt,
    String? updatedAt,
    int? id,
    String? globalId,
    List<SyncedDevice>? syncedDevices,
  }) {
    return Note(
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      globalId: globalId ?? this.globalId,
      syncedDevices: syncedDevices ?? this.syncedDevices,
    );
  }

  @override
  List<Object?> get props =>
      [message, createdAt, updatedAt, id, globalId, syncedDevices];
}

class NoteDataForServer extends Equatable {
  final String message;
  final String createdAt;
  final String updatedAt;
  final int id;
  final String sendToDevice;

  const NoteDataForServer({
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.sendToDevice,
  });

  NoteDataForServer copyWith({
    String? message,
    String? createdAt,
    String? updatedAt,
    int? id,
    String? globalId,
    String? sendToDevice,
  }) {
    return NoteDataForServer(
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      sendToDevice: sendToDevice ?? this.sendToDevice,
    );
  }

  @override
  List<Object?> get props => [message, createdAt, updatedAt, id, sendToDevice];
}
