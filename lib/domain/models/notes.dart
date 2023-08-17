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
  final String title;
  final String message;
  final String createdAt;
  final String updatedAt;
  final int id;
  final String? globalId;
  final List<SyncedDevice> syncedDevices;

  const Note({
    required this.title,
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
    String? title,
  }) {
    return Note(
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      globalId: globalId ?? this.globalId,
      syncedDevices: syncedDevices ?? this.syncedDevices,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props =>
      [message, createdAt, updatedAt, id, globalId, syncedDevices, title];
}

class NoteDataForServer extends Equatable {
  final String message;
  final String createdAt;
  final String updatedAt;
  final int? globalId;
  final String sendToDevice;
  final String title;

  const NoteDataForServer({
    required this.title,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.sendToDevice,
    this.globalId,
  });

  NoteDataForServer copyWith({
    String? title,
    String? message,
    String? createdAt,
    String? updatedAt,
    int? globalId,
    String? sendToDevice,
  }) {
    return NoteDataForServer(
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sendToDevice: sendToDevice ?? this.sendToDevice,
      globalId: globalId ?? this.globalId,
    );
  }

  @override
  List<Object?> get props =>
      [message, createdAt, updatedAt, sendToDevice, globalId, title];
}
