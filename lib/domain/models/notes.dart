import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String message;
  final String createdAt;
  final String updatedAt;
  final int id;
  final String? tempLocalId;

  const Note({
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.tempLocalId,
  });

  Note copyWith({
    String? message,
    String? createdAt,
    String? updatedAt,
    int? id,
    String? tempLocalId,
  }) {
    return Note(
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      tempLocalId: tempLocalId ?? this.tempLocalId,
    );
  }

  @override
  List<Object?> get props => [message, createdAt, updatedAt, id, tempLocalId];
}
