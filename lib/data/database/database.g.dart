// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $NotesTable extends Notes with TableInfo<$NotesTable, NoteDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _globalIdMeta =
      const VerificationMeta('globalId');
  @override
  late final GeneratedColumn<int> globalId = GeneratedColumn<int>(
      'global_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().millisecondsSinceEpoch.toString());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().millisecondsSinceEpoch.toString());
  static const VerificationMeta _syncedDevicesJsonMeta =
      const VerificationMeta('syncedDevicesJson');
  @override
  late final GeneratedColumn<String> syncedDevicesJson =
      GeneratedColumn<String>('synced_devices_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, globalId, message, createdAt, updatedAt, syncedDevicesJson];
  @override
  String get aliasedName => _alias ?? 'notes';
  @override
  String get actualTableName => 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<NoteDb> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('global_id')) {
      context.handle(_globalIdMeta,
          globalId.isAcceptableOrUnknown(data['global_id']!, _globalIdMeta));
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('synced_devices_json')) {
      context.handle(
          _syncedDevicesJsonMeta,
          syncedDevicesJson.isAcceptableOrUnknown(
              data['synced_devices_json']!, _syncedDevicesJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteDb(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      globalId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}global_id']),
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      syncedDevicesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}synced_devices_json'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class NoteDb extends DataClass implements Insertable<NoteDb> {
  final int id;
  final int? globalId;
  final String message;
  final String createdAt;
  final String updatedAt;
  final String syncedDevicesJson;
  const NoteDb(
      {required this.id,
      this.globalId,
      required this.message,
      required this.createdAt,
      required this.updatedAt,
      required this.syncedDevicesJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || globalId != null) {
      map['global_id'] = Variable<int>(globalId);
    }
    map['message'] = Variable<String>(message);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['synced_devices_json'] = Variable<String>(syncedDevicesJson);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      globalId: globalId == null && nullToAbsent
          ? const Value.absent()
          : Value(globalId),
      message: Value(message),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncedDevicesJson: Value(syncedDevicesJson),
    );
  }

  factory NoteDb.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteDb(
      id: serializer.fromJson<int>(json['id']),
      globalId: serializer.fromJson<int?>(json['globalId']),
      message: serializer.fromJson<String>(json['message']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      syncedDevicesJson: serializer.fromJson<String>(json['syncedDevicesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'globalId': serializer.toJson<int?>(globalId),
      'message': serializer.toJson<String>(message),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncedDevicesJson': serializer.toJson<String>(syncedDevicesJson),
    };
  }

  NoteDb copyWith(
          {int? id,
          Value<int?> globalId = const Value.absent(),
          String? message,
          String? createdAt,
          String? updatedAt,
          String? syncedDevicesJson}) =>
      NoteDb(
        id: id ?? this.id,
        globalId: globalId.present ? globalId.value : this.globalId,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncedDevicesJson: syncedDevicesJson ?? this.syncedDevicesJson,
      );
  @override
  String toString() {
    return (StringBuffer('NoteDb(')
          ..write('id: $id, ')
          ..write('globalId: $globalId, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedDevicesJson: $syncedDevicesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, globalId, message, createdAt, updatedAt, syncedDevicesJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteDb &&
          other.id == this.id &&
          other.globalId == this.globalId &&
          other.message == this.message &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncedDevicesJson == this.syncedDevicesJson);
}

class NotesCompanion extends UpdateCompanion<NoteDb> {
  final Value<int> id;
  final Value<int?> globalId;
  final Value<String> message;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncedDevicesJson;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.globalId = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedDevicesJson = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.globalId = const Value.absent(),
    required String message,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedDevicesJson = const Value.absent(),
  }) : message = Value(message);
  static Insertable<NoteDb> custom({
    Expression<int>? id,
    Expression<int>? globalId,
    Expression<String>? message,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncedDevicesJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (globalId != null) 'global_id': globalId,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedDevicesJson != null) 'synced_devices_json': syncedDevicesJson,
    });
  }

  NotesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? globalId,
      Value<String>? message,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<String>? syncedDevicesJson}) {
    return NotesCompanion(
      id: id ?? this.id,
      globalId: globalId ?? this.globalId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedDevicesJson: syncedDevicesJson ?? this.syncedDevicesJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (globalId.present) {
      map['global_id'] = Variable<int>(globalId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (syncedDevicesJson.present) {
      map['synced_devices_json'] = Variable<String>(syncedDevicesJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('globalId: $globalId, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedDevicesJson: $syncedDevicesJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $NotesTable notes = $NotesTable(this);
  late final NotesDao notesDao = NotesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes];
}
