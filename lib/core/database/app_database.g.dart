// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OutboxEntriesTable extends OutboxEntries
    with TableInfo<$OutboxEntriesTable, OutboxEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  late final GeneratedColumnWithTypeConverter<OutboxOperation, String>
  operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<OutboxOperation>($OutboxEntriesTable.$converteroperation);
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta(
    'nextAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>(
        'next_attempt_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entity,
    entityId,
    batchId,
    operation,
    payload,
    attempts,
    nextAttemptAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(
          data['next_attempt_at']!,
          _nextAttemptAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextAttemptAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      operation: $OutboxEntriesTable.$converteroperation.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}operation'],
        )!,
      ),
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_attempt_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OutboxEntriesTable createAlias(String alias) {
    return $OutboxEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OutboxOperation, String, String>
  $converteroperation = const EnumNameConverter<OutboxOperation>(
    OutboxOperation.values,
  );
}

class OutboxEntry extends DataClass implements Insertable<OutboxEntry> {
  final int id;

  /// Collection the entry belongs to.
  final String entity;
  final String entityId;

  /// Entradas con el mismo [batchId] viajan en UN solo lote atómico de
  /// Firestore: las reglas validan unas escrituras contra otras (`getAfter`).
  /// Vacío = entrada suelta.
  final String batchId;
  final OutboxOperation operation;

  /// JSON body to send; empty for deletes.
  final String payload;
  final int attempts;
  final DateTime nextAttemptAt;
  final DateTime createdAt;
  const OutboxEntry({
    required this.id,
    required this.entity,
    required this.entityId,
    required this.batchId,
    required this.operation,
    required this.payload,
    required this.attempts,
    required this.nextAttemptAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity'] = Variable<String>(entity);
    map['entity_id'] = Variable<String>(entityId);
    map['batch_id'] = Variable<String>(batchId);
    {
      map['operation'] = Variable<String>(
        $OutboxEntriesTable.$converteroperation.toSql(operation),
      );
    }
    map['payload'] = Variable<String>(payload);
    map['attempts'] = Variable<int>(attempts);
    map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OutboxEntriesCompanion toCompanion(bool nullToAbsent) {
    return OutboxEntriesCompanion(
      id: Value(id),
      entity: Value(entity),
      entityId: Value(entityId),
      batchId: Value(batchId),
      operation: Value(operation),
      payload: Value(payload),
      attempts: Value(attempts),
      nextAttemptAt: Value(nextAttemptAt),
      createdAt: Value(createdAt),
    );
  }

  factory OutboxEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxEntry(
      id: serializer.fromJson<int>(json['id']),
      entity: serializer.fromJson<String>(json['entity']),
      entityId: serializer.fromJson<String>(json['entityId']),
      batchId: serializer.fromJson<String>(json['batchId']),
      operation: $OutboxEntriesTable.$converteroperation.fromJson(
        serializer.fromJson<String>(json['operation']),
      ),
      payload: serializer.fromJson<String>(json['payload']),
      attempts: serializer.fromJson<int>(json['attempts']),
      nextAttemptAt: serializer.fromJson<DateTime>(json['nextAttemptAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entity': serializer.toJson<String>(entity),
      'entityId': serializer.toJson<String>(entityId),
      'batchId': serializer.toJson<String>(batchId),
      'operation': serializer.toJson<String>(
        $OutboxEntriesTable.$converteroperation.toJson(operation),
      ),
      'payload': serializer.toJson<String>(payload),
      'attempts': serializer.toJson<int>(attempts),
      'nextAttemptAt': serializer.toJson<DateTime>(nextAttemptAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OutboxEntry copyWith({
    int? id,
    String? entity,
    String? entityId,
    String? batchId,
    OutboxOperation? operation,
    String? payload,
    int? attempts,
    DateTime? nextAttemptAt,
    DateTime? createdAt,
  }) => OutboxEntry(
    id: id ?? this.id,
    entity: entity ?? this.entity,
    entityId: entityId ?? this.entityId,
    batchId: batchId ?? this.batchId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    attempts: attempts ?? this.attempts,
    nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
    createdAt: createdAt ?? this.createdAt,
  );
  OutboxEntry copyWithCompanion(OutboxEntriesCompanion data) {
    return OutboxEntry(
      id: data.id.present ? data.id.value : this.id,
      entity: data.entity.present ? data.entity.value : this.entity,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntry(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('batchId: $batchId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entity,
    entityId,
    batchId,
    operation,
    payload,
    attempts,
    nextAttemptAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxEntry &&
          other.id == this.id &&
          other.entity == this.entity &&
          other.entityId == this.entityId &&
          other.batchId == this.batchId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.attempts == this.attempts &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.createdAt == this.createdAt);
}

class OutboxEntriesCompanion extends UpdateCompanion<OutboxEntry> {
  final Value<int> id;
  final Value<String> entity;
  final Value<String> entityId;
  final Value<String> batchId;
  final Value<OutboxOperation> operation;
  final Value<String> payload;
  final Value<int> attempts;
  final Value<DateTime> nextAttemptAt;
  final Value<DateTime> createdAt;
  const OutboxEntriesCompanion({
    this.id = const Value.absent(),
    this.entity = const Value.absent(),
    this.entityId = const Value.absent(),
    this.batchId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OutboxEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String entity,
    required String entityId,
    this.batchId = const Value.absent(),
    required OutboxOperation operation,
    this.payload = const Value.absent(),
    this.attempts = const Value.absent(),
    required DateTime nextAttemptAt,
    required DateTime createdAt,
  }) : entity = Value(entity),
       entityId = Value(entityId),
       operation = Value(operation),
       nextAttemptAt = Value(nextAttemptAt),
       createdAt = Value(createdAt);
  static Insertable<OutboxEntry> custom({
    Expression<int>? id,
    Expression<String>? entity,
    Expression<String>? entityId,
    Expression<String>? batchId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<int>? attempts,
    Expression<DateTime>? nextAttemptAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entity != null) 'entity': entity,
      if (entityId != null) 'entity_id': entityId,
      if (batchId != null) 'batch_id': batchId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (attempts != null) 'attempts': attempts,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OutboxEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? entity,
    Value<String>? entityId,
    Value<String>? batchId,
    Value<OutboxOperation>? operation,
    Value<String>? payload,
    Value<int>? attempts,
    Value<DateTime>? nextAttemptAt,
    Value<DateTime>? createdAt,
  }) {
    return OutboxEntriesCompanion(
      id: id ?? this.id,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      batchId: batchId ?? this.batchId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      attempts: attempts ?? this.attempts,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(
        $OutboxEntriesTable.$converteroperation.toSql(operation.value),
      );
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntriesCompanion(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('batchId: $batchId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TeamsTable extends Teams with TableInfo<$TeamsTable, TeamRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adminIdMeta = const VerificationMeta(
    'adminId',
  );
  @override
  late final GeneratedColumn<String> adminId = GeneratedColumn<String>(
    'admin_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inviteCodeMeta = const VerificationMeta(
    'inviteCode',
  );
  @override
  late final GeneratedColumn<String> inviteCode = GeneratedColumn<String>(
    'invite_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    adminId,
    inviteCode,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('admin_id')) {
      context.handle(
        _adminIdMeta,
        adminId.isAcceptableOrUnknown(data['admin_id']!, _adminIdMeta),
      );
    } else if (isInserting) {
      context.missing(_adminIdMeta);
    }
    if (data.containsKey('invite_code')) {
      context.handle(
        _inviteCodeMeta,
        inviteCode.isAcceptableOrUnknown(data['invite_code']!, _inviteCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_inviteCodeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      adminId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admin_id'],
      )!,
      inviteCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invite_code'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TeamsTable createAlias(String alias) {
    return $TeamsTable(attachedDatabase, alias);
  }
}

class TeamRow extends DataClass implements Insertable<TeamRow> {
  final String id;
  final String name;
  final String adminId;
  final String inviteCode;
  final DateTime createdAt;
  const TeamRow({
    required this.id,
    required this.name,
    required this.adminId,
    required this.inviteCode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['admin_id'] = Variable<String>(adminId);
    map['invite_code'] = Variable<String>(inviteCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TeamsCompanion toCompanion(bool nullToAbsent) {
    return TeamsCompanion(
      id: Value(id),
      name: Value(name),
      adminId: Value(adminId),
      inviteCode: Value(inviteCode),
      createdAt: Value(createdAt),
    );
  }

  factory TeamRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      adminId: serializer.fromJson<String>(json['adminId']),
      inviteCode: serializer.fromJson<String>(json['inviteCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'adminId': serializer.toJson<String>(adminId),
      'inviteCode': serializer.toJson<String>(inviteCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TeamRow copyWith({
    String? id,
    String? name,
    String? adminId,
    String? inviteCode,
    DateTime? createdAt,
  }) => TeamRow(
    id: id ?? this.id,
    name: name ?? this.name,
    adminId: adminId ?? this.adminId,
    inviteCode: inviteCode ?? this.inviteCode,
    createdAt: createdAt ?? this.createdAt,
  );
  TeamRow copyWithCompanion(TeamsCompanion data) {
    return TeamRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      adminId: data.adminId.present ? data.adminId.value : this.adminId,
      inviteCode: data.inviteCode.present
          ? data.inviteCode.value
          : this.inviteCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('adminId: $adminId, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, adminId, inviteCode, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.adminId == this.adminId &&
          other.inviteCode == this.inviteCode &&
          other.createdAt == this.createdAt);
}

class TeamsCompanion extends UpdateCompanion<TeamRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> adminId;
  final Value<String> inviteCode;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TeamsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.adminId = const Value.absent(),
    this.inviteCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamsCompanion.insert({
    required String id,
    required String name,
    required String adminId,
    required String inviteCode,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       adminId = Value(adminId),
       inviteCode = Value(inviteCode),
       createdAt = Value(createdAt);
  static Insertable<TeamRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? adminId,
    Expression<String>? inviteCode,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (adminId != null) 'admin_id': adminId,
      if (inviteCode != null) 'invite_code': inviteCode,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? adminId,
    Value<String>? inviteCode,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TeamsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      adminId: adminId ?? this.adminId,
      inviteCode: inviteCode ?? this.inviteCode,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (adminId.present) {
      map['admin_id'] = Variable<String>(adminId.value);
    }
    if (inviteCode.present) {
      map['invite_code'] = Variable<String>(inviteCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('adminId: $adminId, ')
          ..write('inviteCode: $inviteCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TeamMembersTable extends TeamMembers
    with TableInfo<$TeamMembersTable, TeamMemberRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TeamRole, String> role =
      GeneratedColumn<String>(
        'role',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TeamRole>($TeamMembersTable.$converterrole);
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
    'joined_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    teamId,
    userId,
    role,
    joinedAt,
    displayName,
    photoUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamMemberRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_joinedAtMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {teamId, userId};
  @override
  TeamMemberRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamMemberRow(
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      role: $TeamMembersTable.$converterrole.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}role'],
        )!,
      ),
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_at'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
    );
  }

  @override
  $TeamMembersTable createAlias(String alias) {
    return $TeamMembersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TeamRole, String, String> $converterrole =
      const EnumNameConverter<TeamRole>(TeamRole.values);
}

class TeamMemberRow extends DataClass implements Insertable<TeamMemberRow> {
  final String teamId;
  final String userId;
  final TeamRole role;
  final DateTime joinedAt;
  final String displayName;
  final String? photoUrl;
  const TeamMemberRow({
    required this.teamId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    required this.displayName,
    this.photoUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['team_id'] = Variable<String>(teamId);
    map['user_id'] = Variable<String>(userId);
    {
      map['role'] = Variable<String>(
        $TeamMembersTable.$converterrole.toSql(role),
      );
    }
    map['joined_at'] = Variable<DateTime>(joinedAt);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    return map;
  }

  TeamMembersCompanion toCompanion(bool nullToAbsent) {
    return TeamMembersCompanion(
      teamId: Value(teamId),
      userId: Value(userId),
      role: Value(role),
      joinedAt: Value(joinedAt),
      displayName: Value(displayName),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
    );
  }

  factory TeamMemberRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamMemberRow(
      teamId: serializer.fromJson<String>(json['teamId']),
      userId: serializer.fromJson<String>(json['userId']),
      role: $TeamMembersTable.$converterrole.fromJson(
        serializer.fromJson<String>(json['role']),
      ),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
      displayName: serializer.fromJson<String>(json['displayName']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'teamId': serializer.toJson<String>(teamId),
      'userId': serializer.toJson<String>(userId),
      'role': serializer.toJson<String>(
        $TeamMembersTable.$converterrole.toJson(role),
      ),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
      'displayName': serializer.toJson<String>(displayName),
      'photoUrl': serializer.toJson<String?>(photoUrl),
    };
  }

  TeamMemberRow copyWith({
    String? teamId,
    String? userId,
    TeamRole? role,
    DateTime? joinedAt,
    String? displayName,
    Value<String?> photoUrl = const Value.absent(),
  }) => TeamMemberRow(
    teamId: teamId ?? this.teamId,
    userId: userId ?? this.userId,
    role: role ?? this.role,
    joinedAt: joinedAt ?? this.joinedAt,
    displayName: displayName ?? this.displayName,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
  );
  TeamMemberRow copyWithCompanion(TeamMembersCompanion data) {
    return TeamMemberRow(
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamMemberRow(')
          ..write('teamId: $teamId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('displayName: $displayName, ')
          ..write('photoUrl: $photoUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(teamId, userId, role, joinedAt, displayName, photoUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamMemberRow &&
          other.teamId == this.teamId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.joinedAt == this.joinedAt &&
          other.displayName == this.displayName &&
          other.photoUrl == this.photoUrl);
}

class TeamMembersCompanion extends UpdateCompanion<TeamMemberRow> {
  final Value<String> teamId;
  final Value<String> userId;
  final Value<TeamRole> role;
  final Value<DateTime> joinedAt;
  final Value<String> displayName;
  final Value<String?> photoUrl;
  final Value<int> rowid;
  const TeamMembersCompanion({
    this.teamId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.displayName = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamMembersCompanion.insert({
    required String teamId,
    required String userId,
    required TeamRole role,
    required DateTime joinedAt,
    required String displayName,
    this.photoUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : teamId = Value(teamId),
       userId = Value(userId),
       role = Value(role),
       joinedAt = Value(joinedAt),
       displayName = Value(displayName);
  static Insertable<TeamMemberRow> custom({
    Expression<String>? teamId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<DateTime>? joinedAt,
    Expression<String>? displayName,
    Expression<String>? photoUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (teamId != null) 'team_id': teamId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (displayName != null) 'display_name': displayName,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamMembersCompanion copyWith({
    Value<String>? teamId,
    Value<String>? userId,
    Value<TeamRole>? role,
    Value<DateTime>? joinedAt,
    Value<String>? displayName,
    Value<String?>? photoUrl,
    Value<int>? rowid,
  }) {
    return TeamMembersCompanion(
      teamId: teamId ?? this.teamId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(
        $TeamMembersTable.$converterrole.toSql(role.value),
      );
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamMembersCompanion(')
          ..write('teamId: $teamId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('displayName: $displayName, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PayoutMethodsTable extends PayoutMethods
    with TableInfo<$PayoutMethodsTable, PayoutMethodRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayoutMethodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PayoutMethodType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PayoutMethodType>($PayoutMethodsTable.$convertertype);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _holderNameMeta = const VerificationMeta(
    'holderName',
  );
  @override
  late final GeneratedColumn<String> holderName = GeneratedColumn<String>(
    'holder_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    teamId,
    userId,
    type,
    number,
    bankName,
    holderName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payout_methods';
  @override
  VerificationContext validateIntegrity(
    Insertable<PayoutMethodRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    }
    if (data.containsKey('holder_name')) {
      context.handle(
        _holderNameMeta,
        holderName.isAcceptableOrUnknown(data['holder_name']!, _holderNameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {teamId, userId};
  @override
  PayoutMethodRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayoutMethodRow(
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      type: $PayoutMethodsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      ),
      holderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}holder_name'],
      ),
    );
  }

  @override
  $PayoutMethodsTable createAlias(String alias) {
    return $PayoutMethodsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PayoutMethodType, String, String> $convertertype =
      const EnumNameConverter<PayoutMethodType>(PayoutMethodType.values);
}

class PayoutMethodRow extends DataClass implements Insertable<PayoutMethodRow> {
  final String teamId;
  final String userId;
  final PayoutMethodType type;
  final String number;
  final String? bankName;
  final String? holderName;
  const PayoutMethodRow({
    required this.teamId,
    required this.userId,
    required this.type,
    required this.number,
    this.bankName,
    this.holderName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['team_id'] = Variable<String>(teamId);
    map['user_id'] = Variable<String>(userId);
    {
      map['type'] = Variable<String>(
        $PayoutMethodsTable.$convertertype.toSql(type),
      );
    }
    map['number'] = Variable<String>(number);
    if (!nullToAbsent || bankName != null) {
      map['bank_name'] = Variable<String>(bankName);
    }
    if (!nullToAbsent || holderName != null) {
      map['holder_name'] = Variable<String>(holderName);
    }
    return map;
  }

  PayoutMethodsCompanion toCompanion(bool nullToAbsent) {
    return PayoutMethodsCompanion(
      teamId: Value(teamId),
      userId: Value(userId),
      type: Value(type),
      number: Value(number),
      bankName: bankName == null && nullToAbsent
          ? const Value.absent()
          : Value(bankName),
      holderName: holderName == null && nullToAbsent
          ? const Value.absent()
          : Value(holderName),
    );
  }

  factory PayoutMethodRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayoutMethodRow(
      teamId: serializer.fromJson<String>(json['teamId']),
      userId: serializer.fromJson<String>(json['userId']),
      type: $PayoutMethodsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      number: serializer.fromJson<String>(json['number']),
      bankName: serializer.fromJson<String?>(json['bankName']),
      holderName: serializer.fromJson<String?>(json['holderName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'teamId': serializer.toJson<String>(teamId),
      'userId': serializer.toJson<String>(userId),
      'type': serializer.toJson<String>(
        $PayoutMethodsTable.$convertertype.toJson(type),
      ),
      'number': serializer.toJson<String>(number),
      'bankName': serializer.toJson<String?>(bankName),
      'holderName': serializer.toJson<String?>(holderName),
    };
  }

  PayoutMethodRow copyWith({
    String? teamId,
    String? userId,
    PayoutMethodType? type,
    String? number,
    Value<String?> bankName = const Value.absent(),
    Value<String?> holderName = const Value.absent(),
  }) => PayoutMethodRow(
    teamId: teamId ?? this.teamId,
    userId: userId ?? this.userId,
    type: type ?? this.type,
    number: number ?? this.number,
    bankName: bankName.present ? bankName.value : this.bankName,
    holderName: holderName.present ? holderName.value : this.holderName,
  );
  PayoutMethodRow copyWithCompanion(PayoutMethodsCompanion data) {
    return PayoutMethodRow(
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      userId: data.userId.present ? data.userId.value : this.userId,
      type: data.type.present ? data.type.value : this.type,
      number: data.number.present ? data.number.value : this.number,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      holderName: data.holderName.present
          ? data.holderName.value
          : this.holderName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PayoutMethodRow(')
          ..write('teamId: $teamId, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('number: $number, ')
          ..write('bankName: $bankName, ')
          ..write('holderName: $holderName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(teamId, userId, type, number, bankName, holderName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayoutMethodRow &&
          other.teamId == this.teamId &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.number == this.number &&
          other.bankName == this.bankName &&
          other.holderName == this.holderName);
}

class PayoutMethodsCompanion extends UpdateCompanion<PayoutMethodRow> {
  final Value<String> teamId;
  final Value<String> userId;
  final Value<PayoutMethodType> type;
  final Value<String> number;
  final Value<String?> bankName;
  final Value<String?> holderName;
  final Value<int> rowid;
  const PayoutMethodsCompanion({
    this.teamId = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.number = const Value.absent(),
    this.bankName = const Value.absent(),
    this.holderName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PayoutMethodsCompanion.insert({
    required String teamId,
    required String userId,
    required PayoutMethodType type,
    required String number,
    this.bankName = const Value.absent(),
    this.holderName = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : teamId = Value(teamId),
       userId = Value(userId),
       type = Value(type),
       number = Value(number);
  static Insertable<PayoutMethodRow> custom({
    Expression<String>? teamId,
    Expression<String>? userId,
    Expression<String>? type,
    Expression<String>? number,
    Expression<String>? bankName,
    Expression<String>? holderName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (teamId != null) 'team_id': teamId,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (number != null) 'number': number,
      if (bankName != null) 'bank_name': bankName,
      if (holderName != null) 'holder_name': holderName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PayoutMethodsCompanion copyWith({
    Value<String>? teamId,
    Value<String>? userId,
    Value<PayoutMethodType>? type,
    Value<String>? number,
    Value<String?>? bankName,
    Value<String?>? holderName,
    Value<int>? rowid,
  }) {
    return PayoutMethodsCompanion(
      teamId: teamId ?? this.teamId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      number: number ?? this.number,
      bankName: bankName ?? this.bankName,
      holderName: holderName ?? this.holderName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $PayoutMethodsTable.$convertertype.toSql(type.value),
      );
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (holderName.present) {
      map['holder_name'] = Variable<String>(holderName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayoutMethodsCompanion(')
          ..write('teamId: $teamId, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('number: $number, ')
          ..write('bankName: $bankName, ')
          ..write('holderName: $holderName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, OrderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditorIdMeta = const VerificationMeta(
    'creditorId',
  );
  @override
  late final GeneratedColumn<String> creditorId = GeneratedColumn<String>(
    'creditor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conceptMeta = const VerificationMeta(
    'concept',
  );
  @override
  late final GeneratedColumn<String> concept = GeneratedColumn<String>(
    'concept',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCentsMeta = const VerificationMeta(
    'totalCents',
  );
  @override
  late final GeneratedColumn<int> totalCents = GeneratedColumn<int>(
    'total_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spentAtMeta = const VerificationMeta(
    'spentAt',
  );
  @override
  late final GeneratedColumn<DateTime> spentAt = GeneratedColumn<DateTime>(
    'spent_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teamId,
    creditorId,
    concept,
    note,
    totalCents,
    spentAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('creditor_id')) {
      context.handle(
        _creditorIdMeta,
        creditorId.isAcceptableOrUnknown(data['creditor_id']!, _creditorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_creditorIdMeta);
    }
    if (data.containsKey('concept')) {
      context.handle(
        _conceptMeta,
        concept.isAcceptableOrUnknown(data['concept']!, _conceptMeta),
      );
    } else if (isInserting) {
      context.missing(_conceptMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('total_cents')) {
      context.handle(
        _totalCentsMeta,
        totalCents.isAcceptableOrUnknown(data['total_cents']!, _totalCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCentsMeta);
    }
    if (data.containsKey('spent_at')) {
      context.handle(
        _spentAtMeta,
        spentAt.isAcceptableOrUnknown(data['spent_at']!, _spentAtMeta),
      );
    } else if (isInserting) {
      context.missing(_spentAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      creditorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creditor_id'],
      )!,
      concept: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concept'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      totalCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cents'],
      )!,
      spentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}spent_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class OrderRow extends DataClass implements Insertable<OrderRow> {
  final String id;
  final String teamId;
  final String creditorId;
  final String concept;
  final String? note;
  final int totalCents;
  final DateTime spentAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OrderRow({
    required this.id,
    required this.teamId,
    required this.creditorId,
    required this.concept,
    this.note,
    required this.totalCents,
    required this.spentAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_id'] = Variable<String>(teamId);
    map['creditor_id'] = Variable<String>(creditorId);
    map['concept'] = Variable<String>(concept);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['total_cents'] = Variable<int>(totalCents);
    map['spent_at'] = Variable<DateTime>(spentAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      teamId: Value(teamId),
      creditorId: Value(creditorId),
      concept: Value(concept),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      totalCents: Value(totalCents),
      spentAt: Value(spentAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OrderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderRow(
      id: serializer.fromJson<String>(json['id']),
      teamId: serializer.fromJson<String>(json['teamId']),
      creditorId: serializer.fromJson<String>(json['creditorId']),
      concept: serializer.fromJson<String>(json['concept']),
      note: serializer.fromJson<String?>(json['note']),
      totalCents: serializer.fromJson<int>(json['totalCents']),
      spentAt: serializer.fromJson<DateTime>(json['spentAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamId': serializer.toJson<String>(teamId),
      'creditorId': serializer.toJson<String>(creditorId),
      'concept': serializer.toJson<String>(concept),
      'note': serializer.toJson<String?>(note),
      'totalCents': serializer.toJson<int>(totalCents),
      'spentAt': serializer.toJson<DateTime>(spentAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OrderRow copyWith({
    String? id,
    String? teamId,
    String? creditorId,
    String? concept,
    Value<String?> note = const Value.absent(),
    int? totalCents,
    DateTime? spentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => OrderRow(
    id: id ?? this.id,
    teamId: teamId ?? this.teamId,
    creditorId: creditorId ?? this.creditorId,
    concept: concept ?? this.concept,
    note: note.present ? note.value : this.note,
    totalCents: totalCents ?? this.totalCents,
    spentAt: spentAt ?? this.spentAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  OrderRow copyWithCompanion(OrdersCompanion data) {
    return OrderRow(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      creditorId: data.creditorId.present
          ? data.creditorId.value
          : this.creditorId,
      concept: data.concept.present ? data.concept.value : this.concept,
      note: data.note.present ? data.note.value : this.note,
      totalCents: data.totalCents.present
          ? data.totalCents.value
          : this.totalCents,
      spentAt: data.spentAt.present ? data.spentAt.value : this.spentAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderRow(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('creditorId: $creditorId, ')
          ..write('concept: $concept, ')
          ..write('note: $note, ')
          ..write('totalCents: $totalCents, ')
          ..write('spentAt: $spentAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teamId,
    creditorId,
    concept,
    note,
    totalCents,
    spentAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderRow &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.creditorId == this.creditorId &&
          other.concept == this.concept &&
          other.note == this.note &&
          other.totalCents == this.totalCents &&
          other.spentAt == this.spentAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OrdersCompanion extends UpdateCompanion<OrderRow> {
  final Value<String> id;
  final Value<String> teamId;
  final Value<String> creditorId;
  final Value<String> concept;
  final Value<String?> note;
  final Value<int> totalCents;
  final Value<DateTime> spentAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.creditorId = const Value.absent(),
    this.concept = const Value.absent(),
    this.note = const Value.absent(),
    this.totalCents = const Value.absent(),
    this.spentAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersCompanion.insert({
    required String id,
    required String teamId,
    required String creditorId,
    required String concept,
    this.note = const Value.absent(),
    required int totalCents,
    required DateTime spentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       teamId = Value(teamId),
       creditorId = Value(creditorId),
       concept = Value(concept),
       totalCents = Value(totalCents),
       spentAt = Value(spentAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<OrderRow> custom({
    Expression<String>? id,
    Expression<String>? teamId,
    Expression<String>? creditorId,
    Expression<String>? concept,
    Expression<String>? note,
    Expression<int>? totalCents,
    Expression<DateTime>? spentAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (creditorId != null) 'creditor_id': creditorId,
      if (concept != null) 'concept': concept,
      if (note != null) 'note': note,
      if (totalCents != null) 'total_cents': totalCents,
      if (spentAt != null) 'spent_at': spentAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? teamId,
    Value<String>? creditorId,
    Value<String>? concept,
    Value<String?>? note,
    Value<int>? totalCents,
    Value<DateTime>? spentAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      creditorId: creditorId ?? this.creditorId,
      concept: concept ?? this.concept,
      note: note ?? this.note,
      totalCents: totalCents ?? this.totalCents,
      spentAt: spentAt ?? this.spentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (creditorId.present) {
      map['creditor_id'] = Variable<String>(creditorId.value);
    }
    if (concept.present) {
      map['concept'] = Variable<String>(concept.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (totalCents.present) {
      map['total_cents'] = Variable<int>(totalCents.value);
    }
    if (spentAt.present) {
      map['spent_at'] = Variable<DateTime>(spentAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('creditorId: $creditorId, ')
          ..write('concept: $concept, ')
          ..write('note: $note, ')
          ..write('totalCents: $totalCents, ')
          ..write('spentAt: $spentAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DebtsTable extends Debts with TableInfo<$DebtsTable, DebtRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditorIdMeta = const VerificationMeta(
    'creditorId',
  );
  @override
  late final GeneratedColumn<String> creditorId = GeneratedColumn<String>(
    'creditor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _debtorIdMeta = const VerificationMeta(
    'debtorId',
  );
  @override
  late final GeneratedColumn<String> debtorId = GeneratedColumn<String>(
    'debtor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DebtStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DebtStatus>($DebtsTable.$converterstatus);
  static const VerificationMeta _paymentIdMeta = const VerificationMeta(
    'paymentId',
  );
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
    'payment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    teamId,
    creditorId,
    debtorId,
    amountCents,
    status,
    paymentId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debts';
  @override
  VerificationContext validateIntegrity(
    Insertable<DebtRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('creditor_id')) {
      context.handle(
        _creditorIdMeta,
        creditorId.isAcceptableOrUnknown(data['creditor_id']!, _creditorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_creditorIdMeta);
    }
    if (data.containsKey('debtor_id')) {
      context.handle(
        _debtorIdMeta,
        debtorId.isAcceptableOrUnknown(data['debtor_id']!, _debtorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_debtorIdMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(
        _paymentIdMeta,
        paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DebtRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebtRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      creditorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creditor_id'],
      )!,
      debtorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}debtor_id'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      status: $DebtsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      paymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DebtStatus, String, String> $converterstatus =
      const EnumNameConverter<DebtStatus>(DebtStatus.values);
}

class DebtRow extends DataClass implements Insertable<DebtRow> {
  final String id;
  final String orderId;
  final String teamId;
  final String creditorId;
  final String debtorId;
  final int amountCents;
  final DebtStatus status;
  final String? paymentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DebtRow({
    required this.id,
    required this.orderId,
    required this.teamId,
    required this.creditorId,
    required this.debtorId,
    required this.amountCents,
    required this.status,
    this.paymentId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_id'] = Variable<String>(orderId);
    map['team_id'] = Variable<String>(teamId);
    map['creditor_id'] = Variable<String>(creditorId);
    map['debtor_id'] = Variable<String>(debtorId);
    map['amount_cents'] = Variable<int>(amountCents);
    {
      map['status'] = Variable<String>(
        $DebtsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || paymentId != null) {
      map['payment_id'] = Variable<String>(paymentId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DebtsCompanion toCompanion(bool nullToAbsent) {
    return DebtsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      teamId: Value(teamId),
      creditorId: Value(creditorId),
      debtorId: Value(debtorId),
      amountCents: Value(amountCents),
      status: Value(status),
      paymentId: paymentId == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DebtRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebtRow(
      id: serializer.fromJson<String>(json['id']),
      orderId: serializer.fromJson<String>(json['orderId']),
      teamId: serializer.fromJson<String>(json['teamId']),
      creditorId: serializer.fromJson<String>(json['creditorId']),
      debtorId: serializer.fromJson<String>(json['debtorId']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      status: $DebtsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      paymentId: serializer.fromJson<String?>(json['paymentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderId': serializer.toJson<String>(orderId),
      'teamId': serializer.toJson<String>(teamId),
      'creditorId': serializer.toJson<String>(creditorId),
      'debtorId': serializer.toJson<String>(debtorId),
      'amountCents': serializer.toJson<int>(amountCents),
      'status': serializer.toJson<String>(
        $DebtsTable.$converterstatus.toJson(status),
      ),
      'paymentId': serializer.toJson<String?>(paymentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DebtRow copyWith({
    String? id,
    String? orderId,
    String? teamId,
    String? creditorId,
    String? debtorId,
    int? amountCents,
    DebtStatus? status,
    Value<String?> paymentId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DebtRow(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    teamId: teamId ?? this.teamId,
    creditorId: creditorId ?? this.creditorId,
    debtorId: debtorId ?? this.debtorId,
    amountCents: amountCents ?? this.amountCents,
    status: status ?? this.status,
    paymentId: paymentId.present ? paymentId.value : this.paymentId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DebtRow copyWithCompanion(DebtsCompanion data) {
    return DebtRow(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      creditorId: data.creditorId.present
          ? data.creditorId.value
          : this.creditorId,
      debtorId: data.debtorId.present ? data.debtorId.value : this.debtorId,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      status: data.status.present ? data.status.value : this.status,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DebtRow(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('teamId: $teamId, ')
          ..write('creditorId: $creditorId, ')
          ..write('debtorId: $debtorId, ')
          ..write('amountCents: $amountCents, ')
          ..write('status: $status, ')
          ..write('paymentId: $paymentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    teamId,
    creditorId,
    debtorId,
    amountCents,
    status,
    paymentId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebtRow &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.teamId == this.teamId &&
          other.creditorId == this.creditorId &&
          other.debtorId == this.debtorId &&
          other.amountCents == this.amountCents &&
          other.status == this.status &&
          other.paymentId == this.paymentId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DebtsCompanion extends UpdateCompanion<DebtRow> {
  final Value<String> id;
  final Value<String> orderId;
  final Value<String> teamId;
  final Value<String> creditorId;
  final Value<String> debtorId;
  final Value<int> amountCents;
  final Value<DebtStatus> status;
  final Value<String?> paymentId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DebtsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.creditorId = const Value.absent(),
    this.debtorId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DebtsCompanion.insert({
    required String id,
    required String orderId,
    required String teamId,
    required String creditorId,
    required String debtorId,
    required int amountCents,
    required DebtStatus status,
    this.paymentId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       orderId = Value(orderId),
       teamId = Value(teamId),
       creditorId = Value(creditorId),
       debtorId = Value(debtorId),
       amountCents = Value(amountCents),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DebtRow> custom({
    Expression<String>? id,
    Expression<String>? orderId,
    Expression<String>? teamId,
    Expression<String>? creditorId,
    Expression<String>? debtorId,
    Expression<int>? amountCents,
    Expression<String>? status,
    Expression<String>? paymentId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (teamId != null) 'team_id': teamId,
      if (creditorId != null) 'creditor_id': creditorId,
      if (debtorId != null) 'debtor_id': debtorId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (status != null) 'status': status,
      if (paymentId != null) 'payment_id': paymentId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DebtsCompanion copyWith({
    Value<String>? id,
    Value<String>? orderId,
    Value<String>? teamId,
    Value<String>? creditorId,
    Value<String>? debtorId,
    Value<int>? amountCents,
    Value<DebtStatus>? status,
    Value<String?>? paymentId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DebtsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      teamId: teamId ?? this.teamId,
      creditorId: creditorId ?? this.creditorId,
      debtorId: debtorId ?? this.debtorId,
      amountCents: amountCents ?? this.amountCents,
      status: status ?? this.status,
      paymentId: paymentId ?? this.paymentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (creditorId.present) {
      map['creditor_id'] = Variable<String>(creditorId.value);
    }
    if (debtorId.present) {
      map['debtor_id'] = Variable<String>(debtorId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $DebtsTable.$converterstatus.toSql(status.value),
      );
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('teamId: $teamId, ')
          ..write('creditorId: $creditorId, ')
          ..write('debtorId: $debtorId, ')
          ..write('amountCents: $amountCents, ')
          ..write('status: $status, ')
          ..write('paymentId: $paymentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments
    with TableInfo<$PaymentsTable, PaymentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditorIdMeta = const VerificationMeta(
    'creditorId',
  );
  @override
  late final GeneratedColumn<String> creditorId = GeneratedColumn<String>(
    'creditor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _debtorIdMeta = const VerificationMeta(
    'debtorId',
  );
  @override
  late final GeneratedColumn<String> debtorId = GeneratedColumn<String>(
    'debtor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> debtIds =
      GeneratedColumn<String>(
        'debt_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($PaymentsTable.$converterdebtIds);
  static const VerificationMeta _payoutBankNameMeta = const VerificationMeta(
    'payoutBankName',
  );
  @override
  late final GeneratedColumn<String> payoutBankName = GeneratedColumn<String>(
    'payout_bank_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payoutLast4Meta = const VerificationMeta(
    'payoutLast4',
  );
  @override
  late final GeneratedColumn<String> payoutLast4 = GeneratedColumn<String>(
    'payout_last4',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reportedAtMeta = const VerificationMeta(
    'reportedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reportedAt = GeneratedColumn<DateTime>(
    'reported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _awaitingConfirmationReminderSentMeta =
      const VerificationMeta('awaitingConfirmationReminderSent');
  @override
  late final GeneratedColumn<bool> awaitingConfirmationReminderSent =
      GeneratedColumn<bool>(
        'awaiting_confirmation_reminder_sent',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("awaiting_confirmation_reminder_sent" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teamId,
    creditorId,
    debtorId,
    debtIds,
    payoutBankName,
    payoutLast4,
    reference,
    reportedAt,
    awaitingConfirmationReminderSent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('creditor_id')) {
      context.handle(
        _creditorIdMeta,
        creditorId.isAcceptableOrUnknown(data['creditor_id']!, _creditorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_creditorIdMeta);
    }
    if (data.containsKey('debtor_id')) {
      context.handle(
        _debtorIdMeta,
        debtorId.isAcceptableOrUnknown(data['debtor_id']!, _debtorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_debtorIdMeta);
    }
    if (data.containsKey('payout_bank_name')) {
      context.handle(
        _payoutBankNameMeta,
        payoutBankName.isAcceptableOrUnknown(
          data['payout_bank_name']!,
          _payoutBankNameMeta,
        ),
      );
    }
    if (data.containsKey('payout_last4')) {
      context.handle(
        _payoutLast4Meta,
        payoutLast4.isAcceptableOrUnknown(
          data['payout_last4']!,
          _payoutLast4Meta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payoutLast4Meta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    }
    if (data.containsKey('reported_at')) {
      context.handle(
        _reportedAtMeta,
        reportedAt.isAcceptableOrUnknown(data['reported_at']!, _reportedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reportedAtMeta);
    }
    if (data.containsKey('awaiting_confirmation_reminder_sent')) {
      context.handle(
        _awaitingConfirmationReminderSentMeta,
        awaitingConfirmationReminderSent.isAcceptableOrUnknown(
          data['awaiting_confirmation_reminder_sent']!,
          _awaitingConfirmationReminderSentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      creditorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creditor_id'],
      )!,
      debtorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}debtor_id'],
      )!,
      debtIds: $PaymentsTable.$converterdebtIds.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}debt_ids'],
        )!,
      ),
      payoutBankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payout_bank_name'],
      ),
      payoutLast4: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payout_last4'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      ),
      reportedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reported_at'],
      )!,
      awaitingConfirmationReminderSent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}awaiting_confirmation_reminder_sent'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterdebtIds =
      const StringListConverter();
}

class PaymentRow extends DataClass implements Insertable<PaymentRow> {
  final String id;
  final String teamId;
  final String creditorId;
  final String debtorId;
  final List<String> debtIds;
  final String? payoutBankName;
  final String payoutLast4;
  final String? reference;
  final DateTime reportedAt;
  final bool awaitingConfirmationReminderSent;
  const PaymentRow({
    required this.id,
    required this.teamId,
    required this.creditorId,
    required this.debtorId,
    required this.debtIds,
    this.payoutBankName,
    required this.payoutLast4,
    this.reference,
    required this.reportedAt,
    required this.awaitingConfirmationReminderSent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_id'] = Variable<String>(teamId);
    map['creditor_id'] = Variable<String>(creditorId);
    map['debtor_id'] = Variable<String>(debtorId);
    {
      map['debt_ids'] = Variable<String>(
        $PaymentsTable.$converterdebtIds.toSql(debtIds),
      );
    }
    if (!nullToAbsent || payoutBankName != null) {
      map['payout_bank_name'] = Variable<String>(payoutBankName);
    }
    map['payout_last4'] = Variable<String>(payoutLast4);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    map['reported_at'] = Variable<DateTime>(reportedAt);
    map['awaiting_confirmation_reminder_sent'] = Variable<bool>(
      awaitingConfirmationReminderSent,
    );
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      teamId: Value(teamId),
      creditorId: Value(creditorId),
      debtorId: Value(debtorId),
      debtIds: Value(debtIds),
      payoutBankName: payoutBankName == null && nullToAbsent
          ? const Value.absent()
          : Value(payoutBankName),
      payoutLast4: Value(payoutLast4),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      reportedAt: Value(reportedAt),
      awaitingConfirmationReminderSent: Value(awaitingConfirmationReminderSent),
    );
  }

  factory PaymentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentRow(
      id: serializer.fromJson<String>(json['id']),
      teamId: serializer.fromJson<String>(json['teamId']),
      creditorId: serializer.fromJson<String>(json['creditorId']),
      debtorId: serializer.fromJson<String>(json['debtorId']),
      debtIds: serializer.fromJson<List<String>>(json['debtIds']),
      payoutBankName: serializer.fromJson<String?>(json['payoutBankName']),
      payoutLast4: serializer.fromJson<String>(json['payoutLast4']),
      reference: serializer.fromJson<String?>(json['reference']),
      reportedAt: serializer.fromJson<DateTime>(json['reportedAt']),
      awaitingConfirmationReminderSent: serializer.fromJson<bool>(
        json['awaitingConfirmationReminderSent'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamId': serializer.toJson<String>(teamId),
      'creditorId': serializer.toJson<String>(creditorId),
      'debtorId': serializer.toJson<String>(debtorId),
      'debtIds': serializer.toJson<List<String>>(debtIds),
      'payoutBankName': serializer.toJson<String?>(payoutBankName),
      'payoutLast4': serializer.toJson<String>(payoutLast4),
      'reference': serializer.toJson<String?>(reference),
      'reportedAt': serializer.toJson<DateTime>(reportedAt),
      'awaitingConfirmationReminderSent': serializer.toJson<bool>(
        awaitingConfirmationReminderSent,
      ),
    };
  }

  PaymentRow copyWith({
    String? id,
    String? teamId,
    String? creditorId,
    String? debtorId,
    List<String>? debtIds,
    Value<String?> payoutBankName = const Value.absent(),
    String? payoutLast4,
    Value<String?> reference = const Value.absent(),
    DateTime? reportedAt,
    bool? awaitingConfirmationReminderSent,
  }) => PaymentRow(
    id: id ?? this.id,
    teamId: teamId ?? this.teamId,
    creditorId: creditorId ?? this.creditorId,
    debtorId: debtorId ?? this.debtorId,
    debtIds: debtIds ?? this.debtIds,
    payoutBankName: payoutBankName.present
        ? payoutBankName.value
        : this.payoutBankName,
    payoutLast4: payoutLast4 ?? this.payoutLast4,
    reference: reference.present ? reference.value : this.reference,
    reportedAt: reportedAt ?? this.reportedAt,
    awaitingConfirmationReminderSent:
        awaitingConfirmationReminderSent ??
        this.awaitingConfirmationReminderSent,
  );
  PaymentRow copyWithCompanion(PaymentsCompanion data) {
    return PaymentRow(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      creditorId: data.creditorId.present
          ? data.creditorId.value
          : this.creditorId,
      debtorId: data.debtorId.present ? data.debtorId.value : this.debtorId,
      debtIds: data.debtIds.present ? data.debtIds.value : this.debtIds,
      payoutBankName: data.payoutBankName.present
          ? data.payoutBankName.value
          : this.payoutBankName,
      payoutLast4: data.payoutLast4.present
          ? data.payoutLast4.value
          : this.payoutLast4,
      reference: data.reference.present ? data.reference.value : this.reference,
      reportedAt: data.reportedAt.present
          ? data.reportedAt.value
          : this.reportedAt,
      awaitingConfirmationReminderSent:
          data.awaitingConfirmationReminderSent.present
          ? data.awaitingConfirmationReminderSent.value
          : this.awaitingConfirmationReminderSent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentRow(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('creditorId: $creditorId, ')
          ..write('debtorId: $debtorId, ')
          ..write('debtIds: $debtIds, ')
          ..write('payoutBankName: $payoutBankName, ')
          ..write('payoutLast4: $payoutLast4, ')
          ..write('reference: $reference, ')
          ..write('reportedAt: $reportedAt, ')
          ..write(
            'awaitingConfirmationReminderSent: $awaitingConfirmationReminderSent',
          )
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teamId,
    creditorId,
    debtorId,
    debtIds,
    payoutBankName,
    payoutLast4,
    reference,
    reportedAt,
    awaitingConfirmationReminderSent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentRow &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.creditorId == this.creditorId &&
          other.debtorId == this.debtorId &&
          other.debtIds == this.debtIds &&
          other.payoutBankName == this.payoutBankName &&
          other.payoutLast4 == this.payoutLast4 &&
          other.reference == this.reference &&
          other.reportedAt == this.reportedAt &&
          other.awaitingConfirmationReminderSent ==
              this.awaitingConfirmationReminderSent);
}

class PaymentsCompanion extends UpdateCompanion<PaymentRow> {
  final Value<String> id;
  final Value<String> teamId;
  final Value<String> creditorId;
  final Value<String> debtorId;
  final Value<List<String>> debtIds;
  final Value<String?> payoutBankName;
  final Value<String> payoutLast4;
  final Value<String?> reference;
  final Value<DateTime> reportedAt;
  final Value<bool> awaitingConfirmationReminderSent;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.creditorId = const Value.absent(),
    this.debtorId = const Value.absent(),
    this.debtIds = const Value.absent(),
    this.payoutBankName = const Value.absent(),
    this.payoutLast4 = const Value.absent(),
    this.reference = const Value.absent(),
    this.reportedAt = const Value.absent(),
    this.awaitingConfirmationReminderSent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    required String id,
    required String teamId,
    required String creditorId,
    required String debtorId,
    required List<String> debtIds,
    this.payoutBankName = const Value.absent(),
    required String payoutLast4,
    this.reference = const Value.absent(),
    required DateTime reportedAt,
    this.awaitingConfirmationReminderSent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       teamId = Value(teamId),
       creditorId = Value(creditorId),
       debtorId = Value(debtorId),
       debtIds = Value(debtIds),
       payoutLast4 = Value(payoutLast4),
       reportedAt = Value(reportedAt);
  static Insertable<PaymentRow> custom({
    Expression<String>? id,
    Expression<String>? teamId,
    Expression<String>? creditorId,
    Expression<String>? debtorId,
    Expression<String>? debtIds,
    Expression<String>? payoutBankName,
    Expression<String>? payoutLast4,
    Expression<String>? reference,
    Expression<DateTime>? reportedAt,
    Expression<bool>? awaitingConfirmationReminderSent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (creditorId != null) 'creditor_id': creditorId,
      if (debtorId != null) 'debtor_id': debtorId,
      if (debtIds != null) 'debt_ids': debtIds,
      if (payoutBankName != null) 'payout_bank_name': payoutBankName,
      if (payoutLast4 != null) 'payout_last4': payoutLast4,
      if (reference != null) 'reference': reference,
      if (reportedAt != null) 'reported_at': reportedAt,
      if (awaitingConfirmationReminderSent != null)
        'awaiting_confirmation_reminder_sent': awaitingConfirmationReminderSent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? teamId,
    Value<String>? creditorId,
    Value<String>? debtorId,
    Value<List<String>>? debtIds,
    Value<String?>? payoutBankName,
    Value<String>? payoutLast4,
    Value<String?>? reference,
    Value<DateTime>? reportedAt,
    Value<bool>? awaitingConfirmationReminderSent,
    Value<int>? rowid,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      creditorId: creditorId ?? this.creditorId,
      debtorId: debtorId ?? this.debtorId,
      debtIds: debtIds ?? this.debtIds,
      payoutBankName: payoutBankName ?? this.payoutBankName,
      payoutLast4: payoutLast4 ?? this.payoutLast4,
      reference: reference ?? this.reference,
      reportedAt: reportedAt ?? this.reportedAt,
      awaitingConfirmationReminderSent:
          awaitingConfirmationReminderSent ??
          this.awaitingConfirmationReminderSent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (creditorId.present) {
      map['creditor_id'] = Variable<String>(creditorId.value);
    }
    if (debtorId.present) {
      map['debtor_id'] = Variable<String>(debtorId.value);
    }
    if (debtIds.present) {
      map['debt_ids'] = Variable<String>(
        $PaymentsTable.$converterdebtIds.toSql(debtIds.value),
      );
    }
    if (payoutBankName.present) {
      map['payout_bank_name'] = Variable<String>(payoutBankName.value);
    }
    if (payoutLast4.present) {
      map['payout_last4'] = Variable<String>(payoutLast4.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (reportedAt.present) {
      map['reported_at'] = Variable<DateTime>(reportedAt.value);
    }
    if (awaitingConfirmationReminderSent.present) {
      map['awaiting_confirmation_reminder_sent'] = Variable<bool>(
        awaitingConfirmationReminderSent.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('creditorId: $creditorId, ')
          ..write('debtorId: $debtorId, ')
          ..write('debtIds: $debtIds, ')
          ..write('payoutBankName: $payoutBankName, ')
          ..write('payoutLast4: $payoutLast4, ')
          ..write('reference: $reference, ')
          ..write('reportedAt: $reportedAt, ')
          ..write(
            'awaitingConfirmationReminderSent: $awaitingConfirmationReminderSent, ',
          )
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LedgerEntriesTable extends LedgerEntries
    with TableInfo<$LedgerEntriesTable, LedgerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LedgerEventType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LedgerEventType>($LedgerEntriesTable.$convertertype);
  static const VerificationMeta _actorIdMeta = const VerificationMeta(
    'actorId',
  );
  @override
  late final GeneratedColumn<String> actorId = GeneratedColumn<String>(
    'actor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<DateTime> at = GeneratedColumn<DateTime>(
    'at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _debtIdMeta = const VerificationMeta('debtId');
  @override
  late final GeneratedColumn<String> debtId = GeneratedColumn<String>(
    'debt_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentIdMeta = const VerificationMeta(
    'paymentId',
  );
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
    'payment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountBeforeCentsMeta = const VerificationMeta(
    'amountBeforeCents',
  );
  @override
  late final GeneratedColumn<int> amountBeforeCents = GeneratedColumn<int>(
    'amount_before_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountAfterCentsMeta = const VerificationMeta(
    'amountAfterCents',
  );
  @override
  late final GeneratedColumn<int> amountAfterCents = GeneratedColumn<int>(
    'amount_after_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> partyIds =
      GeneratedColumn<String>(
        'party_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($LedgerEntriesTable.$converterpartyIds);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teamId,
    orderId,
    type,
    actorId,
    at,
    debtId,
    paymentId,
    amountBeforeCents,
    amountAfterCents,
    note,
    partyIds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LedgerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('actor_id')) {
      context.handle(
        _actorIdMeta,
        actorId.isAcceptableOrUnknown(data['actor_id']!, _actorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_actorIdMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('debt_id')) {
      context.handle(
        _debtIdMeta,
        debtId.isAcceptableOrUnknown(data['debt_id']!, _debtIdMeta),
      );
    }
    if (data.containsKey('payment_id')) {
      context.handle(
        _paymentIdMeta,
        paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta),
      );
    }
    if (data.containsKey('amount_before_cents')) {
      context.handle(
        _amountBeforeCentsMeta,
        amountBeforeCents.isAcceptableOrUnknown(
          data['amount_before_cents']!,
          _amountBeforeCentsMeta,
        ),
      );
    }
    if (data.containsKey('amount_after_cents')) {
      context.handle(
        _amountAfterCentsMeta,
        amountAfterCents.isAcceptableOrUnknown(
          data['amount_after_cents']!,
          _amountAfterCentsMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LedgerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      type: $LedgerEntriesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      actorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_id'],
      )!,
      at: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}at'],
      )!,
      debtId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}debt_id'],
      ),
      paymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_id'],
      ),
      amountBeforeCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_before_cents'],
      ),
      amountAfterCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_after_cents'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      partyIds: $LedgerEntriesTable.$converterpartyIds.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}party_ids'],
        )!,
      ),
    );
  }

  @override
  $LedgerEntriesTable createAlias(String alias) {
    return $LedgerEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LedgerEventType, String, String> $convertertype =
      const EnumNameConverter<LedgerEventType>(LedgerEventType.values);
  static TypeConverter<List<String>, String> $converterpartyIds =
      const StringListConverter();
}

class LedgerRow extends DataClass implements Insertable<LedgerRow> {
  final String id;
  final String teamId;
  final String orderId;
  final LedgerEventType type;
  final String actorId;
  final DateTime at;
  final String? debtId;
  final String? paymentId;
  final int? amountBeforeCents;
  final int? amountAfterCents;
  final String? note;

  /// Quiénes pueden ver una línea confidencial (acreedor y deudor).
  final List<String> partyIds;
  const LedgerRow({
    required this.id,
    required this.teamId,
    required this.orderId,
    required this.type,
    required this.actorId,
    required this.at,
    this.debtId,
    this.paymentId,
    this.amountBeforeCents,
    this.amountAfterCents,
    this.note,
    required this.partyIds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_id'] = Variable<String>(teamId);
    map['order_id'] = Variable<String>(orderId);
    {
      map['type'] = Variable<String>(
        $LedgerEntriesTable.$convertertype.toSql(type),
      );
    }
    map['actor_id'] = Variable<String>(actorId);
    map['at'] = Variable<DateTime>(at);
    if (!nullToAbsent || debtId != null) {
      map['debt_id'] = Variable<String>(debtId);
    }
    if (!nullToAbsent || paymentId != null) {
      map['payment_id'] = Variable<String>(paymentId);
    }
    if (!nullToAbsent || amountBeforeCents != null) {
      map['amount_before_cents'] = Variable<int>(amountBeforeCents);
    }
    if (!nullToAbsent || amountAfterCents != null) {
      map['amount_after_cents'] = Variable<int>(amountAfterCents);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    {
      map['party_ids'] = Variable<String>(
        $LedgerEntriesTable.$converterpartyIds.toSql(partyIds),
      );
    }
    return map;
  }

  LedgerEntriesCompanion toCompanion(bool nullToAbsent) {
    return LedgerEntriesCompanion(
      id: Value(id),
      teamId: Value(teamId),
      orderId: Value(orderId),
      type: Value(type),
      actorId: Value(actorId),
      at: Value(at),
      debtId: debtId == null && nullToAbsent
          ? const Value.absent()
          : Value(debtId),
      paymentId: paymentId == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentId),
      amountBeforeCents: amountBeforeCents == null && nullToAbsent
          ? const Value.absent()
          : Value(amountBeforeCents),
      amountAfterCents: amountAfterCents == null && nullToAbsent
          ? const Value.absent()
          : Value(amountAfterCents),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      partyIds: Value(partyIds),
    );
  }

  factory LedgerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerRow(
      id: serializer.fromJson<String>(json['id']),
      teamId: serializer.fromJson<String>(json['teamId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      type: $LedgerEntriesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      actorId: serializer.fromJson<String>(json['actorId']),
      at: serializer.fromJson<DateTime>(json['at']),
      debtId: serializer.fromJson<String?>(json['debtId']),
      paymentId: serializer.fromJson<String?>(json['paymentId']),
      amountBeforeCents: serializer.fromJson<int?>(json['amountBeforeCents']),
      amountAfterCents: serializer.fromJson<int?>(json['amountAfterCents']),
      note: serializer.fromJson<String?>(json['note']),
      partyIds: serializer.fromJson<List<String>>(json['partyIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamId': serializer.toJson<String>(teamId),
      'orderId': serializer.toJson<String>(orderId),
      'type': serializer.toJson<String>(
        $LedgerEntriesTable.$convertertype.toJson(type),
      ),
      'actorId': serializer.toJson<String>(actorId),
      'at': serializer.toJson<DateTime>(at),
      'debtId': serializer.toJson<String?>(debtId),
      'paymentId': serializer.toJson<String?>(paymentId),
      'amountBeforeCents': serializer.toJson<int?>(amountBeforeCents),
      'amountAfterCents': serializer.toJson<int?>(amountAfterCents),
      'note': serializer.toJson<String?>(note),
      'partyIds': serializer.toJson<List<String>>(partyIds),
    };
  }

  LedgerRow copyWith({
    String? id,
    String? teamId,
    String? orderId,
    LedgerEventType? type,
    String? actorId,
    DateTime? at,
    Value<String?> debtId = const Value.absent(),
    Value<String?> paymentId = const Value.absent(),
    Value<int?> amountBeforeCents = const Value.absent(),
    Value<int?> amountAfterCents = const Value.absent(),
    Value<String?> note = const Value.absent(),
    List<String>? partyIds,
  }) => LedgerRow(
    id: id ?? this.id,
    teamId: teamId ?? this.teamId,
    orderId: orderId ?? this.orderId,
    type: type ?? this.type,
    actorId: actorId ?? this.actorId,
    at: at ?? this.at,
    debtId: debtId.present ? debtId.value : this.debtId,
    paymentId: paymentId.present ? paymentId.value : this.paymentId,
    amountBeforeCents: amountBeforeCents.present
        ? amountBeforeCents.value
        : this.amountBeforeCents,
    amountAfterCents: amountAfterCents.present
        ? amountAfterCents.value
        : this.amountAfterCents,
    note: note.present ? note.value : this.note,
    partyIds: partyIds ?? this.partyIds,
  );
  LedgerRow copyWithCompanion(LedgerEntriesCompanion data) {
    return LedgerRow(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      type: data.type.present ? data.type.value : this.type,
      actorId: data.actorId.present ? data.actorId.value : this.actorId,
      at: data.at.present ? data.at.value : this.at,
      debtId: data.debtId.present ? data.debtId.value : this.debtId,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      amountBeforeCents: data.amountBeforeCents.present
          ? data.amountBeforeCents.value
          : this.amountBeforeCents,
      amountAfterCents: data.amountAfterCents.present
          ? data.amountAfterCents.value
          : this.amountAfterCents,
      note: data.note.present ? data.note.value : this.note,
      partyIds: data.partyIds.present ? data.partyIds.value : this.partyIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerRow(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('orderId: $orderId, ')
          ..write('type: $type, ')
          ..write('actorId: $actorId, ')
          ..write('at: $at, ')
          ..write('debtId: $debtId, ')
          ..write('paymentId: $paymentId, ')
          ..write('amountBeforeCents: $amountBeforeCents, ')
          ..write('amountAfterCents: $amountAfterCents, ')
          ..write('note: $note, ')
          ..write('partyIds: $partyIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teamId,
    orderId,
    type,
    actorId,
    at,
    debtId,
    paymentId,
    amountBeforeCents,
    amountAfterCents,
    note,
    partyIds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerRow &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.orderId == this.orderId &&
          other.type == this.type &&
          other.actorId == this.actorId &&
          other.at == this.at &&
          other.debtId == this.debtId &&
          other.paymentId == this.paymentId &&
          other.amountBeforeCents == this.amountBeforeCents &&
          other.amountAfterCents == this.amountAfterCents &&
          other.note == this.note &&
          other.partyIds == this.partyIds);
}

class LedgerEntriesCompanion extends UpdateCompanion<LedgerRow> {
  final Value<String> id;
  final Value<String> teamId;
  final Value<String> orderId;
  final Value<LedgerEventType> type;
  final Value<String> actorId;
  final Value<DateTime> at;
  final Value<String?> debtId;
  final Value<String?> paymentId;
  final Value<int?> amountBeforeCents;
  final Value<int?> amountAfterCents;
  final Value<String?> note;
  final Value<List<String>> partyIds;
  final Value<int> rowid;
  const LedgerEntriesCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.type = const Value.absent(),
    this.actorId = const Value.absent(),
    this.at = const Value.absent(),
    this.debtId = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.amountBeforeCents = const Value.absent(),
    this.amountAfterCents = const Value.absent(),
    this.note = const Value.absent(),
    this.partyIds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LedgerEntriesCompanion.insert({
    required String id,
    required String teamId,
    required String orderId,
    required LedgerEventType type,
    required String actorId,
    required DateTime at,
    this.debtId = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.amountBeforeCents = const Value.absent(),
    this.amountAfterCents = const Value.absent(),
    this.note = const Value.absent(),
    required List<String> partyIds,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       teamId = Value(teamId),
       orderId = Value(orderId),
       type = Value(type),
       actorId = Value(actorId),
       at = Value(at),
       partyIds = Value(partyIds);
  static Insertable<LedgerRow> custom({
    Expression<String>? id,
    Expression<String>? teamId,
    Expression<String>? orderId,
    Expression<String>? type,
    Expression<String>? actorId,
    Expression<DateTime>? at,
    Expression<String>? debtId,
    Expression<String>? paymentId,
    Expression<int>? amountBeforeCents,
    Expression<int>? amountAfterCents,
    Expression<String>? note,
    Expression<String>? partyIds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (orderId != null) 'order_id': orderId,
      if (type != null) 'type': type,
      if (actorId != null) 'actor_id': actorId,
      if (at != null) 'at': at,
      if (debtId != null) 'debt_id': debtId,
      if (paymentId != null) 'payment_id': paymentId,
      if (amountBeforeCents != null) 'amount_before_cents': amountBeforeCents,
      if (amountAfterCents != null) 'amount_after_cents': amountAfterCents,
      if (note != null) 'note': note,
      if (partyIds != null) 'party_ids': partyIds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LedgerEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? teamId,
    Value<String>? orderId,
    Value<LedgerEventType>? type,
    Value<String>? actorId,
    Value<DateTime>? at,
    Value<String?>? debtId,
    Value<String?>? paymentId,
    Value<int?>? amountBeforeCents,
    Value<int?>? amountAfterCents,
    Value<String?>? note,
    Value<List<String>>? partyIds,
    Value<int>? rowid,
  }) {
    return LedgerEntriesCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      orderId: orderId ?? this.orderId,
      type: type ?? this.type,
      actorId: actorId ?? this.actorId,
      at: at ?? this.at,
      debtId: debtId ?? this.debtId,
      paymentId: paymentId ?? this.paymentId,
      amountBeforeCents: amountBeforeCents ?? this.amountBeforeCents,
      amountAfterCents: amountAfterCents ?? this.amountAfterCents,
      note: note ?? this.note,
      partyIds: partyIds ?? this.partyIds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $LedgerEntriesTable.$convertertype.toSql(type.value),
      );
    }
    if (actorId.present) {
      map['actor_id'] = Variable<String>(actorId.value);
    }
    if (at.present) {
      map['at'] = Variable<DateTime>(at.value);
    }
    if (debtId.present) {
      map['debt_id'] = Variable<String>(debtId.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (amountBeforeCents.present) {
      map['amount_before_cents'] = Variable<int>(amountBeforeCents.value);
    }
    if (amountAfterCents.present) {
      map['amount_after_cents'] = Variable<int>(amountAfterCents.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (partyIds.present) {
      map['party_ids'] = Variable<String>(
        $LedgerEntriesTable.$converterpartyIds.toSql(partyIds.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('orderId: $orderId, ')
          ..write('type: $type, ')
          ..write('actorId: $actorId, ')
          ..write('at: $at, ')
          ..write('debtId: $debtId, ')
          ..write('paymentId: $paymentId, ')
          ..write('amountBeforeCents: $amountBeforeCents, ')
          ..write('amountAfterCents: $amountAfterCents, ')
          ..write('note: $note, ')
          ..write('partyIds: $partyIds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NoticeRecordsTable extends NoticeRecords
    with TableInfo<$NoticeRecordsTable, NoticeRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoticeRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  recipientIds = GeneratedColumn<String>(
    'recipient_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<String>>($NoticeRecordsTable.$converterrecipientIds);
  @override
  late final GeneratedColumnWithTypeConverter<NoticeTemplate?, String>
  template = GeneratedColumn<String>(
    'template',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<NoticeTemplate?>($NoticeRecordsTable.$convertertemplaten);
  static const VerificationMeta _customTextMeta = const VerificationMeta(
    'customText',
  );
  @override
  late final GeneratedColumn<String> customText = GeneratedColumn<String>(
    'custom_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teamId,
    senderId,
    recipientIds,
    template,
    customText,
    sentAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notice_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<NoticeRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('custom_text')) {
      context.handle(
        _customTextMeta,
        customText.isAcceptableOrUnknown(data['custom_text']!, _customTextMeta),
      );
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    } else if (isInserting) {
      context.missing(_sentAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoticeRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoticeRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      recipientIds: $NoticeRecordsTable.$converterrecipientIds.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}recipient_ids'],
        )!,
      ),
      template: $NoticeRecordsTable.$convertertemplaten.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}template'],
        ),
      ),
      customText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_text'],
      ),
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      )!,
    );
  }

  @override
  $NoticeRecordsTable createAlias(String alias) {
    return $NoticeRecordsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterrecipientIds =
      const StringListConverter();
  static JsonTypeConverter2<NoticeTemplate, String, String> $convertertemplate =
      const EnumNameConverter<NoticeTemplate>(NoticeTemplate.values);
  static JsonTypeConverter2<NoticeTemplate?, String?, String?>
  $convertertemplaten = JsonTypeConverter2.asNullable($convertertemplate);
}

class NoticeRecordRow extends DataClass implements Insertable<NoticeRecordRow> {
  final String id;
  final String teamId;
  final String senderId;
  final List<String> recipientIds;
  final NoticeTemplate? template;
  final String? customText;
  final DateTime sentAt;
  const NoticeRecordRow({
    required this.id,
    required this.teamId,
    required this.senderId,
    required this.recipientIds,
    this.template,
    this.customText,
    required this.sentAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_id'] = Variable<String>(teamId);
    map['sender_id'] = Variable<String>(senderId);
    {
      map['recipient_ids'] = Variable<String>(
        $NoticeRecordsTable.$converterrecipientIds.toSql(recipientIds),
      );
    }
    if (!nullToAbsent || template != null) {
      map['template'] = Variable<String>(
        $NoticeRecordsTable.$convertertemplaten.toSql(template),
      );
    }
    if (!nullToAbsent || customText != null) {
      map['custom_text'] = Variable<String>(customText);
    }
    map['sent_at'] = Variable<DateTime>(sentAt);
    return map;
  }

  NoticeRecordsCompanion toCompanion(bool nullToAbsent) {
    return NoticeRecordsCompanion(
      id: Value(id),
      teamId: Value(teamId),
      senderId: Value(senderId),
      recipientIds: Value(recipientIds),
      template: template == null && nullToAbsent
          ? const Value.absent()
          : Value(template),
      customText: customText == null && nullToAbsent
          ? const Value.absent()
          : Value(customText),
      sentAt: Value(sentAt),
    );
  }

  factory NoticeRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoticeRecordRow(
      id: serializer.fromJson<String>(json['id']),
      teamId: serializer.fromJson<String>(json['teamId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      recipientIds: serializer.fromJson<List<String>>(json['recipientIds']),
      template: $NoticeRecordsTable.$convertertemplaten.fromJson(
        serializer.fromJson<String?>(json['template']),
      ),
      customText: serializer.fromJson<String?>(json['customText']),
      sentAt: serializer.fromJson<DateTime>(json['sentAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamId': serializer.toJson<String>(teamId),
      'senderId': serializer.toJson<String>(senderId),
      'recipientIds': serializer.toJson<List<String>>(recipientIds),
      'template': serializer.toJson<String?>(
        $NoticeRecordsTable.$convertertemplaten.toJson(template),
      ),
      'customText': serializer.toJson<String?>(customText),
      'sentAt': serializer.toJson<DateTime>(sentAt),
    };
  }

  NoticeRecordRow copyWith({
    String? id,
    String? teamId,
    String? senderId,
    List<String>? recipientIds,
    Value<NoticeTemplate?> template = const Value.absent(),
    Value<String?> customText = const Value.absent(),
    DateTime? sentAt,
  }) => NoticeRecordRow(
    id: id ?? this.id,
    teamId: teamId ?? this.teamId,
    senderId: senderId ?? this.senderId,
    recipientIds: recipientIds ?? this.recipientIds,
    template: template.present ? template.value : this.template,
    customText: customText.present ? customText.value : this.customText,
    sentAt: sentAt ?? this.sentAt,
  );
  NoticeRecordRow copyWithCompanion(NoticeRecordsCompanion data) {
    return NoticeRecordRow(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      recipientIds: data.recipientIds.present
          ? data.recipientIds.value
          : this.recipientIds,
      template: data.template.present ? data.template.value : this.template,
      customText: data.customText.present
          ? data.customText.value
          : this.customText,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoticeRecordRow(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('senderId: $senderId, ')
          ..write('recipientIds: $recipientIds, ')
          ..write('template: $template, ')
          ..write('customText: $customText, ')
          ..write('sentAt: $sentAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teamId,
    senderId,
    recipientIds,
    template,
    customText,
    sentAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoticeRecordRow &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.senderId == this.senderId &&
          other.recipientIds == this.recipientIds &&
          other.template == this.template &&
          other.customText == this.customText &&
          other.sentAt == this.sentAt);
}

class NoticeRecordsCompanion extends UpdateCompanion<NoticeRecordRow> {
  final Value<String> id;
  final Value<String> teamId;
  final Value<String> senderId;
  final Value<List<String>> recipientIds;
  final Value<NoticeTemplate?> template;
  final Value<String?> customText;
  final Value<DateTime> sentAt;
  final Value<int> rowid;
  const NoticeRecordsCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.recipientIds = const Value.absent(),
    this.template = const Value.absent(),
    this.customText = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NoticeRecordsCompanion.insert({
    required String id,
    required String teamId,
    required String senderId,
    required List<String> recipientIds,
    this.template = const Value.absent(),
    this.customText = const Value.absent(),
    required DateTime sentAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       teamId = Value(teamId),
       senderId = Value(senderId),
       recipientIds = Value(recipientIds),
       sentAt = Value(sentAt);
  static Insertable<NoticeRecordRow> custom({
    Expression<String>? id,
    Expression<String>? teamId,
    Expression<String>? senderId,
    Expression<String>? recipientIds,
    Expression<String>? template,
    Expression<String>? customText,
    Expression<DateTime>? sentAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (senderId != null) 'sender_id': senderId,
      if (recipientIds != null) 'recipient_ids': recipientIds,
      if (template != null) 'template': template,
      if (customText != null) 'custom_text': customText,
      if (sentAt != null) 'sent_at': sentAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NoticeRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? teamId,
    Value<String>? senderId,
    Value<List<String>>? recipientIds,
    Value<NoticeTemplate?>? template,
    Value<String?>? customText,
    Value<DateTime>? sentAt,
    Value<int>? rowid,
  }) {
    return NoticeRecordsCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      senderId: senderId ?? this.senderId,
      recipientIds: recipientIds ?? this.recipientIds,
      template: template ?? this.template,
      customText: customText ?? this.customText,
      sentAt: sentAt ?? this.sentAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (recipientIds.present) {
      map['recipient_ids'] = Variable<String>(
        $NoticeRecordsTable.$converterrecipientIds.toSql(recipientIds.value),
      );
    }
    if (template.present) {
      map['template'] = Variable<String>(
        $NoticeRecordsTable.$convertertemplaten.toSql(template.value),
      );
    }
    if (customText.present) {
      map['custom_text'] = Variable<String>(customText.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoticeRecordsCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('senderId: $senderId, ')
          ..write('recipientIds: $recipientIds, ')
          ..write('template: $template, ')
          ..write('customText: $customText, ')
          ..write('sentAt: $sentAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InboxNotificationsTable extends InboxNotifications
    with TableInfo<$InboxNotificationsTable, InboxNotificationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InboxNotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipientIdMeta = const VerificationMeta(
    'recipientId',
  );
  @override
  late final GeneratedColumn<String> recipientId = GeneratedColumn<String>(
    'recipient_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<NotificationKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<NotificationKind>(
        $InboxNotificationsTable.$converterkind,
      );
  static const VerificationMeta _actorIdMeta = const VerificationMeta(
    'actorId',
  );
  @override
  late final GeneratedColumn<String> actorId = GeneratedColumn<String>(
    'actor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<NotificationTargetType, String>
  targetType =
      GeneratedColumn<String>(
        'target_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<NotificationTargetType>(
        $InboxNotificationsTable.$convertertargetType,
      );
  static const VerificationMeta _targetIdMeta = const VerificationMeta(
    'targetId',
  );
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
    'target_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conceptMeta = const VerificationMeta(
    'concept',
  );
  @override
  late final GeneratedColumn<String> concept = GeneratedColumn<String>(
    'concept',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _debtCountMeta = const VerificationMeta(
    'debtCount',
  );
  @override
  late final GeneratedColumn<int> debtCount = GeneratedColumn<int>(
    'debt_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rejectedCountMeta = const VerificationMeta(
    'rejectedCount',
  );
  @override
  late final GeneratedColumn<int> rejectedCount = GeneratedColumn<int>(
    'rejected_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateKeyMeta = const VerificationMeta(
    'templateKey',
  );
  @override
  late final GeneratedColumn<String> templateKey = GeneratedColumn<String>(
    'template_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<DateTime> readAt = GeneratedColumn<DateTime>(
    'read_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipientId,
    kind,
    actorId,
    teamId,
    targetType,
    targetId,
    amountCents,
    concept,
    debtCount,
    rejectedCount,
    note,
    templateKey,
    createdAt,
    readAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inbox_notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<InboxNotificationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recipient_id')) {
      context.handle(
        _recipientIdMeta,
        recipientId.isAcceptableOrUnknown(
          data['recipient_id']!,
          _recipientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recipientIdMeta);
    }
    if (data.containsKey('actor_id')) {
      context.handle(
        _actorIdMeta,
        actorId.isAcceptableOrUnknown(data['actor_id']!, _actorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_actorIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(
        _targetIdMeta,
        targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    }
    if (data.containsKey('concept')) {
      context.handle(
        _conceptMeta,
        concept.isAcceptableOrUnknown(data['concept']!, _conceptMeta),
      );
    }
    if (data.containsKey('debt_count')) {
      context.handle(
        _debtCountMeta,
        debtCount.isAcceptableOrUnknown(data['debt_count']!, _debtCountMeta),
      );
    }
    if (data.containsKey('rejected_count')) {
      context.handle(
        _rejectedCountMeta,
        rejectedCount.isAcceptableOrUnknown(
          data['rejected_count']!,
          _rejectedCountMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('template_key')) {
      context.handle(
        _templateKeyMeta,
        templateKey.isAcceptableOrUnknown(
          data['template_key']!,
          _templateKeyMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('read_at')) {
      context.handle(
        _readAtMeta,
        readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InboxNotificationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InboxNotificationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recipientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_id'],
      )!,
      kind: $InboxNotificationsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      actorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      targetType: $InboxNotificationsTable.$convertertargetType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}target_type'],
        )!,
      ),
      targetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_id'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      ),
      concept: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concept'],
      ),
      debtCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}debt_count'],
      ),
      rejectedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rejected_count'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      templateKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_key'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      readAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}read_at'],
      ),
    );
  }

  @override
  $InboxNotificationsTable createAlias(String alias) {
    return $InboxNotificationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<NotificationKind, String, String> $converterkind =
      const EnumNameConverter<NotificationKind>(NotificationKind.values);
  static JsonTypeConverter2<NotificationTargetType, String, String>
  $convertertargetType = const EnumNameConverter<NotificationTargetType>(
    NotificationTargetType.values,
  );
}

class InboxNotificationRow extends DataClass
    implements Insertable<InboxNotificationRow> {
  final String id;
  final String recipientId;
  final NotificationKind kind;
  final String actorId;
  final String teamId;
  final NotificationTargetType targetType;
  final String targetId;
  final int? amountCents;
  final String? concept;
  final int? debtCount;
  final int? rejectedCount;
  final String? note;
  final String? templateKey;
  final DateTime createdAt;
  final DateTime? readAt;
  const InboxNotificationRow({
    required this.id,
    required this.recipientId,
    required this.kind,
    required this.actorId,
    required this.teamId,
    required this.targetType,
    required this.targetId,
    this.amountCents,
    this.concept,
    this.debtCount,
    this.rejectedCount,
    this.note,
    this.templateKey,
    required this.createdAt,
    this.readAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recipient_id'] = Variable<String>(recipientId);
    {
      map['kind'] = Variable<String>(
        $InboxNotificationsTable.$converterkind.toSql(kind),
      );
    }
    map['actor_id'] = Variable<String>(actorId);
    map['team_id'] = Variable<String>(teamId);
    {
      map['target_type'] = Variable<String>(
        $InboxNotificationsTable.$convertertargetType.toSql(targetType),
      );
    }
    map['target_id'] = Variable<String>(targetId);
    if (!nullToAbsent || amountCents != null) {
      map['amount_cents'] = Variable<int>(amountCents);
    }
    if (!nullToAbsent || concept != null) {
      map['concept'] = Variable<String>(concept);
    }
    if (!nullToAbsent || debtCount != null) {
      map['debt_count'] = Variable<int>(debtCount);
    }
    if (!nullToAbsent || rejectedCount != null) {
      map['rejected_count'] = Variable<int>(rejectedCount);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || templateKey != null) {
      map['template_key'] = Variable<String>(templateKey);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || readAt != null) {
      map['read_at'] = Variable<DateTime>(readAt);
    }
    return map;
  }

  InboxNotificationsCompanion toCompanion(bool nullToAbsent) {
    return InboxNotificationsCompanion(
      id: Value(id),
      recipientId: Value(recipientId),
      kind: Value(kind),
      actorId: Value(actorId),
      teamId: Value(teamId),
      targetType: Value(targetType),
      targetId: Value(targetId),
      amountCents: amountCents == null && nullToAbsent
          ? const Value.absent()
          : Value(amountCents),
      concept: concept == null && nullToAbsent
          ? const Value.absent()
          : Value(concept),
      debtCount: debtCount == null && nullToAbsent
          ? const Value.absent()
          : Value(debtCount),
      rejectedCount: rejectedCount == null && nullToAbsent
          ? const Value.absent()
          : Value(rejectedCount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      templateKey: templateKey == null && nullToAbsent
          ? const Value.absent()
          : Value(templateKey),
      createdAt: Value(createdAt),
      readAt: readAt == null && nullToAbsent
          ? const Value.absent()
          : Value(readAt),
    );
  }

  factory InboxNotificationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InboxNotificationRow(
      id: serializer.fromJson<String>(json['id']),
      recipientId: serializer.fromJson<String>(json['recipientId']),
      kind: $InboxNotificationsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      actorId: serializer.fromJson<String>(json['actorId']),
      teamId: serializer.fromJson<String>(json['teamId']),
      targetType: $InboxNotificationsTable.$convertertargetType.fromJson(
        serializer.fromJson<String>(json['targetType']),
      ),
      targetId: serializer.fromJson<String>(json['targetId']),
      amountCents: serializer.fromJson<int?>(json['amountCents']),
      concept: serializer.fromJson<String?>(json['concept']),
      debtCount: serializer.fromJson<int?>(json['debtCount']),
      rejectedCount: serializer.fromJson<int?>(json['rejectedCount']),
      note: serializer.fromJson<String?>(json['note']),
      templateKey: serializer.fromJson<String?>(json['templateKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      readAt: serializer.fromJson<DateTime?>(json['readAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recipientId': serializer.toJson<String>(recipientId),
      'kind': serializer.toJson<String>(
        $InboxNotificationsTable.$converterkind.toJson(kind),
      ),
      'actorId': serializer.toJson<String>(actorId),
      'teamId': serializer.toJson<String>(teamId),
      'targetType': serializer.toJson<String>(
        $InboxNotificationsTable.$convertertargetType.toJson(targetType),
      ),
      'targetId': serializer.toJson<String>(targetId),
      'amountCents': serializer.toJson<int?>(amountCents),
      'concept': serializer.toJson<String?>(concept),
      'debtCount': serializer.toJson<int?>(debtCount),
      'rejectedCount': serializer.toJson<int?>(rejectedCount),
      'note': serializer.toJson<String?>(note),
      'templateKey': serializer.toJson<String?>(templateKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'readAt': serializer.toJson<DateTime?>(readAt),
    };
  }

  InboxNotificationRow copyWith({
    String? id,
    String? recipientId,
    NotificationKind? kind,
    String? actorId,
    String? teamId,
    NotificationTargetType? targetType,
    String? targetId,
    Value<int?> amountCents = const Value.absent(),
    Value<String?> concept = const Value.absent(),
    Value<int?> debtCount = const Value.absent(),
    Value<int?> rejectedCount = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> templateKey = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> readAt = const Value.absent(),
  }) => InboxNotificationRow(
    id: id ?? this.id,
    recipientId: recipientId ?? this.recipientId,
    kind: kind ?? this.kind,
    actorId: actorId ?? this.actorId,
    teamId: teamId ?? this.teamId,
    targetType: targetType ?? this.targetType,
    targetId: targetId ?? this.targetId,
    amountCents: amountCents.present ? amountCents.value : this.amountCents,
    concept: concept.present ? concept.value : this.concept,
    debtCount: debtCount.present ? debtCount.value : this.debtCount,
    rejectedCount: rejectedCount.present
        ? rejectedCount.value
        : this.rejectedCount,
    note: note.present ? note.value : this.note,
    templateKey: templateKey.present ? templateKey.value : this.templateKey,
    createdAt: createdAt ?? this.createdAt,
    readAt: readAt.present ? readAt.value : this.readAt,
  );
  InboxNotificationRow copyWithCompanion(InboxNotificationsCompanion data) {
    return InboxNotificationRow(
      id: data.id.present ? data.id.value : this.id,
      recipientId: data.recipientId.present
          ? data.recipientId.value
          : this.recipientId,
      kind: data.kind.present ? data.kind.value : this.kind,
      actorId: data.actorId.present ? data.actorId.value : this.actorId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      targetType: data.targetType.present
          ? data.targetType.value
          : this.targetType,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      concept: data.concept.present ? data.concept.value : this.concept,
      debtCount: data.debtCount.present ? data.debtCount.value : this.debtCount,
      rejectedCount: data.rejectedCount.present
          ? data.rejectedCount.value
          : this.rejectedCount,
      note: data.note.present ? data.note.value : this.note,
      templateKey: data.templateKey.present
          ? data.templateKey.value
          : this.templateKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      readAt: data.readAt.present ? data.readAt.value : this.readAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InboxNotificationRow(')
          ..write('id: $id, ')
          ..write('recipientId: $recipientId, ')
          ..write('kind: $kind, ')
          ..write('actorId: $actorId, ')
          ..write('teamId: $teamId, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('amountCents: $amountCents, ')
          ..write('concept: $concept, ')
          ..write('debtCount: $debtCount, ')
          ..write('rejectedCount: $rejectedCount, ')
          ..write('note: $note, ')
          ..write('templateKey: $templateKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('readAt: $readAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipientId,
    kind,
    actorId,
    teamId,
    targetType,
    targetId,
    amountCents,
    concept,
    debtCount,
    rejectedCount,
    note,
    templateKey,
    createdAt,
    readAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InboxNotificationRow &&
          other.id == this.id &&
          other.recipientId == this.recipientId &&
          other.kind == this.kind &&
          other.actorId == this.actorId &&
          other.teamId == this.teamId &&
          other.targetType == this.targetType &&
          other.targetId == this.targetId &&
          other.amountCents == this.amountCents &&
          other.concept == this.concept &&
          other.debtCount == this.debtCount &&
          other.rejectedCount == this.rejectedCount &&
          other.note == this.note &&
          other.templateKey == this.templateKey &&
          other.createdAt == this.createdAt &&
          other.readAt == this.readAt);
}

class InboxNotificationsCompanion
    extends UpdateCompanion<InboxNotificationRow> {
  final Value<String> id;
  final Value<String> recipientId;
  final Value<NotificationKind> kind;
  final Value<String> actorId;
  final Value<String> teamId;
  final Value<NotificationTargetType> targetType;
  final Value<String> targetId;
  final Value<int?> amountCents;
  final Value<String?> concept;
  final Value<int?> debtCount;
  final Value<int?> rejectedCount;
  final Value<String?> note;
  final Value<String?> templateKey;
  final Value<DateTime> createdAt;
  final Value<DateTime?> readAt;
  final Value<int> rowid;
  const InboxNotificationsCompanion({
    this.id = const Value.absent(),
    this.recipientId = const Value.absent(),
    this.kind = const Value.absent(),
    this.actorId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.targetType = const Value.absent(),
    this.targetId = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.concept = const Value.absent(),
    this.debtCount = const Value.absent(),
    this.rejectedCount = const Value.absent(),
    this.note = const Value.absent(),
    this.templateKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.readAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InboxNotificationsCompanion.insert({
    required String id,
    required String recipientId,
    required NotificationKind kind,
    required String actorId,
    required String teamId,
    required NotificationTargetType targetType,
    required String targetId,
    this.amountCents = const Value.absent(),
    this.concept = const Value.absent(),
    this.debtCount = const Value.absent(),
    this.rejectedCount = const Value.absent(),
    this.note = const Value.absent(),
    this.templateKey = const Value.absent(),
    required DateTime createdAt,
    this.readAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recipientId = Value(recipientId),
       kind = Value(kind),
       actorId = Value(actorId),
       teamId = Value(teamId),
       targetType = Value(targetType),
       targetId = Value(targetId),
       createdAt = Value(createdAt);
  static Insertable<InboxNotificationRow> custom({
    Expression<String>? id,
    Expression<String>? recipientId,
    Expression<String>? kind,
    Expression<String>? actorId,
    Expression<String>? teamId,
    Expression<String>? targetType,
    Expression<String>? targetId,
    Expression<int>? amountCents,
    Expression<String>? concept,
    Expression<int>? debtCount,
    Expression<int>? rejectedCount,
    Expression<String>? note,
    Expression<String>? templateKey,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? readAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipientId != null) 'recipient_id': recipientId,
      if (kind != null) 'kind': kind,
      if (actorId != null) 'actor_id': actorId,
      if (teamId != null) 'team_id': teamId,
      if (targetType != null) 'target_type': targetType,
      if (targetId != null) 'target_id': targetId,
      if (amountCents != null) 'amount_cents': amountCents,
      if (concept != null) 'concept': concept,
      if (debtCount != null) 'debt_count': debtCount,
      if (rejectedCount != null) 'rejected_count': rejectedCount,
      if (note != null) 'note': note,
      if (templateKey != null) 'template_key': templateKey,
      if (createdAt != null) 'created_at': createdAt,
      if (readAt != null) 'read_at': readAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InboxNotificationsCompanion copyWith({
    Value<String>? id,
    Value<String>? recipientId,
    Value<NotificationKind>? kind,
    Value<String>? actorId,
    Value<String>? teamId,
    Value<NotificationTargetType>? targetType,
    Value<String>? targetId,
    Value<int?>? amountCents,
    Value<String?>? concept,
    Value<int?>? debtCount,
    Value<int?>? rejectedCount,
    Value<String?>? note,
    Value<String?>? templateKey,
    Value<DateTime>? createdAt,
    Value<DateTime?>? readAt,
    Value<int>? rowid,
  }) {
    return InboxNotificationsCompanion(
      id: id ?? this.id,
      recipientId: recipientId ?? this.recipientId,
      kind: kind ?? this.kind,
      actorId: actorId ?? this.actorId,
      teamId: teamId ?? this.teamId,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      amountCents: amountCents ?? this.amountCents,
      concept: concept ?? this.concept,
      debtCount: debtCount ?? this.debtCount,
      rejectedCount: rejectedCount ?? this.rejectedCount,
      note: note ?? this.note,
      templateKey: templateKey ?? this.templateKey,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recipientId.present) {
      map['recipient_id'] = Variable<String>(recipientId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $InboxNotificationsTable.$converterkind.toSql(kind.value),
      );
    }
    if (actorId.present) {
      map['actor_id'] = Variable<String>(actorId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (targetType.present) {
      map['target_type'] = Variable<String>(
        $InboxNotificationsTable.$convertertargetType.toSql(targetType.value),
      );
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (concept.present) {
      map['concept'] = Variable<String>(concept.value);
    }
    if (debtCount.present) {
      map['debt_count'] = Variable<int>(debtCount.value);
    }
    if (rejectedCount.present) {
      map['rejected_count'] = Variable<int>(rejectedCount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (templateKey.present) {
      map['template_key'] = Variable<String>(templateKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<DateTime>(readAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InboxNotificationsCompanion(')
          ..write('id: $id, ')
          ..write('recipientId: $recipientId, ')
          ..write('kind: $kind, ')
          ..write('actorId: $actorId, ')
          ..write('teamId: $teamId, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('amountCents: $amountCents, ')
          ..write('concept: $concept, ')
          ..write('debtCount: $debtCount, ')
          ..write('rejectedCount: $rejectedCount, ')
          ..write('note: $note, ')
          ..write('templateKey: $templateKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('readAt: $readAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OutboxEntriesTable outboxEntries = $OutboxEntriesTable(this);
  late final $TeamsTable teams = $TeamsTable(this);
  late final $TeamMembersTable teamMembers = $TeamMembersTable(this);
  late final $PayoutMethodsTable payoutMethods = $PayoutMethodsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $LedgerEntriesTable ledgerEntries = $LedgerEntriesTable(this);
  late final $NoticeRecordsTable noticeRecords = $NoticeRecordsTable(this);
  late final $InboxNotificationsTable inboxNotifications =
      $InboxNotificationsTable(this);
  late final Index outboxNextAttempt = Index(
    'outbox_next_attempt',
    'CREATE INDEX outbox_next_attempt ON outbox_entries (next_attempt_at)',
  );
  late final Index teamMembersUser = Index(
    'team_members_user',
    'CREATE INDEX team_members_user ON team_members (user_id)',
  );
  late final Index ordersTeam = Index(
    'orders_team',
    'CREATE INDEX orders_team ON orders (team_id, spent_at)',
  );
  late final Index debtsOrder = Index(
    'debts_order',
    'CREATE INDEX debts_order ON debts (order_id)',
  );
  late final Index debtsTeamStatus = Index(
    'debts_team_status',
    'CREATE INDEX debts_team_status ON debts (team_id, status)',
  );
  late final Index debtsDebtorStatus = Index(
    'debts_debtor_status',
    'CREATE INDEX debts_debtor_status ON debts (debtor_id, status)',
  );
  late final Index debtsCreditorStatus = Index(
    'debts_creditor_status',
    'CREATE INDEX debts_creditor_status ON debts (creditor_id, status)',
  );
  late final Index debtsPayment = Index(
    'debts_payment',
    'CREATE INDEX debts_payment ON debts (payment_id)',
  );
  late final Index paymentsTeam = Index(
    'payments_team',
    'CREATE INDEX payments_team ON payments (team_id)',
  );
  late final Index ledgerOrder = Index(
    'ledger_order',
    'CREATE INDEX ledger_order ON ledger_entries (order_id, at)',
  );
  late final Index noticeRecordsSender = Index(
    'notice_records_sender',
    'CREATE INDEX notice_records_sender ON notice_records (sender_id, team_id, sent_at)',
  );
  late final Index inboxRecipient = Index(
    'inbox_recipient',
    'CREATE INDEX inbox_recipient ON inbox_notifications (recipient_id, created_at)',
  );
  late final OutboxDao outboxDao = OutboxDao(this as AppDatabase);
  late final TeamsDao teamsDao = TeamsDao(this as AppDatabase);
  late final OrdersDao ordersDao = OrdersDao(this as AppDatabase);
  late final DebtsDao debtsDao = DebtsDao(this as AppDatabase);
  late final PaymentsDao paymentsDao = PaymentsDao(this as AppDatabase);
  late final LedgerDao ledgerDao = LedgerDao(this as AppDatabase);
  late final NoticeRecordsDao noticeRecordsDao = NoticeRecordsDao(
    this as AppDatabase,
  );
  late final InboxDao inboxDao = InboxDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    outboxEntries,
    teams,
    teamMembers,
    payoutMethods,
    orders,
    debts,
    payments,
    ledgerEntries,
    noticeRecords,
    inboxNotifications,
    outboxNextAttempt,
    teamMembersUser,
    ordersTeam,
    debtsOrder,
    debtsTeamStatus,
    debtsDebtorStatus,
    debtsCreditorStatus,
    debtsPayment,
    paymentsTeam,
    ledgerOrder,
    noticeRecordsSender,
    inboxRecipient,
  ];
}

typedef $$OutboxEntriesTableCreateCompanionBuilder =
    OutboxEntriesCompanion Function({
      Value<int> id,
      required String entity,
      required String entityId,
      Value<String> batchId,
      required OutboxOperation operation,
      Value<String> payload,
      Value<int> attempts,
      required DateTime nextAttemptAt,
      required DateTime createdAt,
    });
typedef $$OutboxEntriesTableUpdateCompanionBuilder =
    OutboxEntriesCompanion Function({
      Value<int> id,
      Value<String> entity,
      Value<String> entityId,
      Value<String> batchId,
      Value<OutboxOperation> operation,
      Value<String> payload,
      Value<int> attempts,
      Value<DateTime> nextAttemptAt,
      Value<DateTime> createdAt,
    });

class $$OutboxEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchId => $composableBuilder(
    column: $table.batchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<OutboxOperation, OutboxOperation, String>
  get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboxEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchId => $composableBuilder(
    column: $table.batchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboxEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get batchId =>
      $composableBuilder(column: $table.batchId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OutboxOperation, String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OutboxEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutboxEntriesTable,
          OutboxEntry,
          $$OutboxEntriesTableFilterComposer,
          $$OutboxEntriesTableOrderingComposer,
          $$OutboxEntriesTableAnnotationComposer,
          $$OutboxEntriesTableCreateCompanionBuilder,
          $$OutboxEntriesTableUpdateCompanionBuilder,
          (
            OutboxEntry,
            BaseReferences<_$AppDatabase, $OutboxEntriesTable, OutboxEntry>,
          ),
          OutboxEntry,
          PrefetchHooks Function()
        > {
  $$OutboxEntriesTableTableManager(_$AppDatabase db, $OutboxEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<OutboxOperation> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<DateTime> nextAttemptAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OutboxEntriesCompanion(
                id: id,
                entity: entity,
                entityId: entityId,
                batchId: batchId,
                operation: operation,
                payload: payload,
                attempts: attempts,
                nextAttemptAt: nextAttemptAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entity,
                required String entityId,
                Value<String> batchId = const Value.absent(),
                required OutboxOperation operation,
                Value<String> payload = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                required DateTime nextAttemptAt,
                required DateTime createdAt,
              }) => OutboxEntriesCompanion.insert(
                id: id,
                entity: entity,
                entityId: entityId,
                batchId: batchId,
                operation: operation,
                payload: payload,
                attempts: attempts,
                nextAttemptAt: nextAttemptAt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OutboxEntriesTable, OutboxEntry>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $OutboxEntriesTable,
                    OutboxEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboxEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutboxEntriesTable,
      OutboxEntry,
      $$OutboxEntriesTableFilterComposer,
      $$OutboxEntriesTableOrderingComposer,
      $$OutboxEntriesTableAnnotationComposer,
      $$OutboxEntriesTableCreateCompanionBuilder,
      $$OutboxEntriesTableUpdateCompanionBuilder,
      (
        OutboxEntry,
        BaseReferences<_$AppDatabase, $OutboxEntriesTable, OutboxEntry>,
      ),
      OutboxEntry,
      PrefetchHooks Function()
    >;
typedef $$TeamsTableCreateCompanionBuilder = TeamsCompanion Function({
  required String id,
  required String name,
  required String adminId,
  required String inviteCode,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$TeamsTableUpdateCompanionBuilder = TeamsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> adminId,
  Value<String> inviteCode,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$TeamsTableFilterComposer extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adminId => $composableBuilder(
    column: $table.adminId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adminId => $composableBuilder(
    column: $table.adminId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamsTable> {
  $$TeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get adminId =>
      $composableBuilder(column: $table.adminId, builder: (column) => column);

  GeneratedColumn<String> get inviteCode => $composableBuilder(
    column: $table.inviteCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TeamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamsTable,
          TeamRow,
          $$TeamsTableFilterComposer,
          $$TeamsTableOrderingComposer,
          $$TeamsTableAnnotationComposer,
          $$TeamsTableCreateCompanionBuilder,
          $$TeamsTableUpdateCompanionBuilder,
          (TeamRow, BaseReferences<_$AppDatabase, $TeamsTable, TeamRow>),
          TeamRow,
          PrefetchHooks Function()
        > {
  $$TeamsTableTableManager(_$AppDatabase db, $TeamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> adminId = const Value.absent(),
                Value<String> inviteCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamsCompanion(
                id: id,
                name: name,
                adminId: adminId,
                inviteCode: inviteCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String adminId,
                required String inviteCode,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TeamsCompanion.insert(
                id: id,
                name: name,
                adminId: adminId,
                inviteCode: inviteCode,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TeamsTable, TeamRow>(table),
                  BaseReferences<_$AppDatabase, $TeamsTable, TeamRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamsTable,
      TeamRow,
      $$TeamsTableFilterComposer,
      $$TeamsTableOrderingComposer,
      $$TeamsTableAnnotationComposer,
      $$TeamsTableCreateCompanionBuilder,
      $$TeamsTableUpdateCompanionBuilder,
      (TeamRow, BaseReferences<_$AppDatabase, $TeamsTable, TeamRow>),
      TeamRow,
      PrefetchHooks Function()
    >;
typedef $$TeamMembersTableCreateCompanionBuilder =
    TeamMembersCompanion Function({
      required String teamId,
      required String userId,
      required TeamRole role,
      required DateTime joinedAt,
      required String displayName,
      Value<String?> photoUrl,
      Value<int> rowid,
    });
typedef $$TeamMembersTableUpdateCompanionBuilder =
    TeamMembersCompanion Function({
      Value<String> teamId,
      Value<String> userId,
      Value<TeamRole> role,
      Value<DateTime> joinedAt,
      Value<String> displayName,
      Value<String?> photoUrl,
      Value<int> rowid,
    });

class $$TeamMembersTableFilterComposer
    extends Composer<_$AppDatabase, $TeamMembersTable> {
  $$TeamMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TeamRole, TeamRole, String> get role =>
      $composableBuilder(
        column: $table.role,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TeamMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamMembersTable> {
  $$TeamMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamMembersTable> {
  $$TeamMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TeamRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);
}

class $$TeamMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamMembersTable,
          TeamMemberRow,
          $$TeamMembersTableFilterComposer,
          $$TeamMembersTableOrderingComposer,
          $$TeamMembersTableAnnotationComposer,
          $$TeamMembersTableCreateCompanionBuilder,
          $$TeamMembersTableUpdateCompanionBuilder,
          (
            TeamMemberRow,
            BaseReferences<_$AppDatabase, $TeamMembersTable, TeamMemberRow>,
          ),
          TeamMemberRow,
          PrefetchHooks Function()
        > {
  $$TeamMembersTableTableManager(_$AppDatabase db, $TeamMembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamMembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> teamId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<TeamRole> role = const Value.absent(),
                Value<DateTime> joinedAt = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamMembersCompanion(
                teamId: teamId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
                displayName: displayName,
                photoUrl: photoUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String teamId,
                required String userId,
                required TeamRole role,
                required DateTime joinedAt,
                required String displayName,
                Value<String?> photoUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamMembersCompanion.insert(
                teamId: teamId,
                userId: userId,
                role: role,
                joinedAt: joinedAt,
                displayName: displayName,
                photoUrl: photoUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TeamMembersTable, TeamMemberRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TeamMembersTable,
                    TeamMemberRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TeamMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamMembersTable,
      TeamMemberRow,
      $$TeamMembersTableFilterComposer,
      $$TeamMembersTableOrderingComposer,
      $$TeamMembersTableAnnotationComposer,
      $$TeamMembersTableCreateCompanionBuilder,
      $$TeamMembersTableUpdateCompanionBuilder,
      (
        TeamMemberRow,
        BaseReferences<_$AppDatabase, $TeamMembersTable, TeamMemberRow>,
      ),
      TeamMemberRow,
      PrefetchHooks Function()
    >;
typedef $$PayoutMethodsTableCreateCompanionBuilder =
    PayoutMethodsCompanion Function({
      required String teamId,
      required String userId,
      required PayoutMethodType type,
      required String number,
      Value<String?> bankName,
      Value<String?> holderName,
      Value<int> rowid,
    });
typedef $$PayoutMethodsTableUpdateCompanionBuilder =
    PayoutMethodsCompanion Function({
      Value<String> teamId,
      Value<String> userId,
      Value<PayoutMethodType> type,
      Value<String> number,
      Value<String?> bankName,
      Value<String?> holderName,
      Value<int> rowid,
    });

class $$PayoutMethodsTableFilterComposer
    extends Composer<_$AppDatabase, $PayoutMethodsTable> {
  $$PayoutMethodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PayoutMethodType, PayoutMethodType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PayoutMethodsTableOrderingComposer
    extends Composer<_$AppDatabase, $PayoutMethodsTable> {
  $$PayoutMethodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PayoutMethodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PayoutMethodsTable> {
  $$PayoutMethodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PayoutMethodType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => column,
  );
}

class $$PayoutMethodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PayoutMethodsTable,
          PayoutMethodRow,
          $$PayoutMethodsTableFilterComposer,
          $$PayoutMethodsTableOrderingComposer,
          $$PayoutMethodsTableAnnotationComposer,
          $$PayoutMethodsTableCreateCompanionBuilder,
          $$PayoutMethodsTableUpdateCompanionBuilder,
          (
            PayoutMethodRow,
            BaseReferences<_$AppDatabase, $PayoutMethodsTable, PayoutMethodRow>,
          ),
          PayoutMethodRow,
          PrefetchHooks Function()
        > {
  $$PayoutMethodsTableTableManager(_$AppDatabase db, $PayoutMethodsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayoutMethodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PayoutMethodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PayoutMethodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> teamId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<PayoutMethodType> type = const Value.absent(),
                Value<String> number = const Value.absent(),
                Value<String?> bankName = const Value.absent(),
                Value<String?> holderName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PayoutMethodsCompanion(
                teamId: teamId,
                userId: userId,
                type: type,
                number: number,
                bankName: bankName,
                holderName: holderName,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String teamId,
                required String userId,
                required PayoutMethodType type,
                required String number,
                Value<String?> bankName = const Value.absent(),
                Value<String?> holderName = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PayoutMethodsCompanion.insert(
                teamId: teamId,
                userId: userId,
                type: type,
                number: number,
                bankName: bankName,
                holderName: holderName,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PayoutMethodsTable, PayoutMethodRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PayoutMethodsTable,
                    PayoutMethodRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PayoutMethodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PayoutMethodsTable,
      PayoutMethodRow,
      $$PayoutMethodsTableFilterComposer,
      $$PayoutMethodsTableOrderingComposer,
      $$PayoutMethodsTableAnnotationComposer,
      $$PayoutMethodsTableCreateCompanionBuilder,
      $$PayoutMethodsTableUpdateCompanionBuilder,
      (
        PayoutMethodRow,
        BaseReferences<_$AppDatabase, $PayoutMethodsTable, PayoutMethodRow>,
      ),
      PayoutMethodRow,
      PrefetchHooks Function()
    >;
typedef $$OrdersTableCreateCompanionBuilder = OrdersCompanion Function({
  required String id,
  required String teamId,
  required String creditorId,
  required String concept,
  Value<String?> note,
  required int totalCents,
  required DateTime spentAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$OrdersTableUpdateCompanionBuilder = OrdersCompanion Function({
  Value<String> id,
  Value<String> teamId,
  Value<String> creditorId,
  Value<String> concept,
  Value<String?> note,
  Value<int> totalCents,
  Value<DateTime> spentAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditorId => $composableBuilder(
    column: $table.creditorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concept => $composableBuilder(
    column: $table.concept,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get spentAt => $composableBuilder(
    column: $table.spentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditorId => $composableBuilder(
    column: $table.creditorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concept => $composableBuilder(
    column: $table.concept,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get spentAt => $composableBuilder(
    column: $table.spentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get creditorId => $composableBuilder(
    column: $table.creditorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get concept =>
      $composableBuilder(column: $table.concept, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get spentAt =>
      $composableBuilder(column: $table.spentAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdersTable,
          OrderRow,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (OrderRow, BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>),
          OrderRow,
          PrefetchHooks Function()
        > {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> creditorId = const Value.absent(),
                Value<String> concept = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> totalCents = const Value.absent(),
                Value<DateTime> spentAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                teamId: teamId,
                creditorId: creditorId,
                concept: concept,
                note: note,
                totalCents: totalCents,
                spentAt: spentAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String teamId,
                required String creditorId,
                required String concept,
                Value<String?> note = const Value.absent(),
                required int totalCents,
                required DateTime spentAt,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => OrdersCompanion.insert(
                id: id,
                teamId: teamId,
                creditorId: creditorId,
                concept: concept,
                note: note,
                totalCents: totalCents,
                spentAt: spentAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OrdersTable, OrderRow>(table),
                  BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdersTable,
      OrderRow,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (OrderRow, BaseReferences<_$AppDatabase, $OrdersTable, OrderRow>),
      OrderRow,
      PrefetchHooks Function()
    >;
typedef $$DebtsTableCreateCompanionBuilder = DebtsCompanion Function({
  required String id,
  required String orderId,
  required String teamId,
  required String creditorId,
  required String debtorId,
  required int amountCents,
  required DebtStatus status,
  Value<String?> paymentId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$DebtsTableUpdateCompanionBuilder = DebtsCompanion Function({
  Value<String> id,
  Value<String> orderId,
  Value<String> teamId,
  Value<String> creditorId,
  Value<String> debtorId,
  Value<int> amountCents,
  Value<DebtStatus> status,
  Value<String?> paymentId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$DebtsTableFilterComposer extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditorId => $composableBuilder(
    column: $table.creditorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get debtorId => $composableBuilder(
    column: $table.debtorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DebtStatus, DebtStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get paymentId => $composableBuilder(
    column: $table.paymentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditorId => $composableBuilder(
    column: $table.creditorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get debtorId => $composableBuilder(
    column: $table.debtorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentId => $composableBuilder(
    column: $table.paymentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get creditorId => $composableBuilder(
    column: $table.creditorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get debtorId =>
      $composableBuilder(column: $table.debtorId, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DebtStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get paymentId =>
      $composableBuilder(column: $table.paymentId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DebtsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DebtsTable,
          DebtRow,
          $$DebtsTableFilterComposer,
          $$DebtsTableOrderingComposer,
          $$DebtsTableAnnotationComposer,
          $$DebtsTableCreateCompanionBuilder,
          $$DebtsTableUpdateCompanionBuilder,
          (DebtRow, BaseReferences<_$AppDatabase, $DebtsTable, DebtRow>),
          DebtRow,
          PrefetchHooks Function()
        > {
  $$DebtsTableTableManager(_$AppDatabase db, $DebtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> creditorId = const Value.absent(),
                Value<String> debtorId = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<DebtStatus> status = const Value.absent(),
                Value<String?> paymentId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DebtsCompanion(
                id: id,
                orderId: orderId,
                teamId: teamId,
                creditorId: creditorId,
                debtorId: debtorId,
                amountCents: amountCents,
                status: status,
                paymentId: paymentId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String orderId,
                required String teamId,
                required String creditorId,
                required String debtorId,
                required int amountCents,
                required DebtStatus status,
                Value<String?> paymentId = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DebtsCompanion.insert(
                id: id,
                orderId: orderId,
                teamId: teamId,
                creditorId: creditorId,
                debtorId: debtorId,
                amountCents: amountCents,
                status: status,
                paymentId: paymentId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DebtsTable, DebtRow>(table),
                  BaseReferences<_$AppDatabase, $DebtsTable, DebtRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DebtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DebtsTable,
      DebtRow,
      $$DebtsTableFilterComposer,
      $$DebtsTableOrderingComposer,
      $$DebtsTableAnnotationComposer,
      $$DebtsTableCreateCompanionBuilder,
      $$DebtsTableUpdateCompanionBuilder,
      (DebtRow, BaseReferences<_$AppDatabase, $DebtsTable, DebtRow>),
      DebtRow,
      PrefetchHooks Function()
    >;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  required String id,
  required String teamId,
  required String creditorId,
  required String debtorId,
  required List<String> debtIds,
  Value<String?> payoutBankName,
  required String payoutLast4,
  Value<String?> reference,
  required DateTime reportedAt,
  Value<bool> awaitingConfirmationReminderSent,
  Value<int> rowid,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<String> id,
  Value<String> teamId,
  Value<String> creditorId,
  Value<String> debtorId,
  Value<List<String>> debtIds,
  Value<String?> payoutBankName,
  Value<String> payoutLast4,
  Value<String?> reference,
  Value<DateTime> reportedAt,
  Value<bool> awaitingConfirmationReminderSent,
  Value<int> rowid,
});

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditorId => $composableBuilder(
    column: $table.creditorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get debtorId => $composableBuilder(
    column: $table.debtorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get debtIds => $composableBuilder(
    column: $table.debtIds,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get payoutBankName => $composableBuilder(
    column: $table.payoutBankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payoutLast4 => $composableBuilder(
    column: $table.payoutLast4,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get awaitingConfirmationReminderSent =>
      $composableBuilder(
        column: $table.awaitingConfirmationReminderSent,
        builder: (column) => ColumnFilters(column),
      );
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditorId => $composableBuilder(
    column: $table.creditorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get debtorId => $composableBuilder(
    column: $table.debtorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get debtIds => $composableBuilder(
    column: $table.debtIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payoutBankName => $composableBuilder(
    column: $table.payoutBankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payoutLast4 => $composableBuilder(
    column: $table.payoutLast4,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get awaitingConfirmationReminderSent =>
      $composableBuilder(
        column: $table.awaitingConfirmationReminderSent,
        builder: (column) => ColumnOrderings(column),
      );
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get creditorId => $composableBuilder(
    column: $table.creditorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get debtorId =>
      $composableBuilder(column: $table.debtorId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get debtIds =>
      $composableBuilder(column: $table.debtIds, builder: (column) => column);

  GeneratedColumn<String> get payoutBankName => $composableBuilder(
    column: $table.payoutBankName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payoutLast4 => $composableBuilder(
    column: $table.payoutLast4,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get awaitingConfirmationReminderSent =>
      $composableBuilder(
        column: $table.awaitingConfirmationReminderSent,
        builder: (column) => column,
      );
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          PaymentRow,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (
            PaymentRow,
            BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>,
          ),
          PaymentRow,
          PrefetchHooks Function()
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> creditorId = const Value.absent(),
                Value<String> debtorId = const Value.absent(),
                Value<List<String>> debtIds = const Value.absent(),
                Value<String?> payoutBankName = const Value.absent(),
                Value<String> payoutLast4 = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<DateTime> reportedAt = const Value.absent(),
                Value<bool> awaitingConfirmationReminderSent =
                    const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                teamId: teamId,
                creditorId: creditorId,
                debtorId: debtorId,
                debtIds: debtIds,
                payoutBankName: payoutBankName,
                payoutLast4: payoutLast4,
                reference: reference,
                reportedAt: reportedAt,
                awaitingConfirmationReminderSent:
                    awaitingConfirmationReminderSent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String teamId,
                required String creditorId,
                required String debtorId,
                required List<String> debtIds,
                Value<String?> payoutBankName = const Value.absent(),
                required String payoutLast4,
                Value<String?> reference = const Value.absent(),
                required DateTime reportedAt,
                Value<bool> awaitingConfirmationReminderSent =
                    const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                teamId: teamId,
                creditorId: creditorId,
                debtorId: debtorId,
                debtIds: debtIds,
                payoutBankName: payoutBankName,
                payoutLast4: payoutLast4,
                reference: reference,
                reportedAt: reportedAt,
                awaitingConfirmationReminderSent:
                    awaitingConfirmationReminderSent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentsTable, PaymentRow>(table),
                  BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      PaymentRow,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (PaymentRow, BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow>),
      PaymentRow,
      PrefetchHooks Function()
    >;
typedef $$LedgerEntriesTableCreateCompanionBuilder =
    LedgerEntriesCompanion Function({
      required String id,
      required String teamId,
      required String orderId,
      required LedgerEventType type,
      required String actorId,
      required DateTime at,
      Value<String?> debtId,
      Value<String?> paymentId,
      Value<int?> amountBeforeCents,
      Value<int?> amountAfterCents,
      Value<String?> note,
      required List<String> partyIds,
      Value<int> rowid,
    });
typedef $$LedgerEntriesTableUpdateCompanionBuilder =
    LedgerEntriesCompanion Function({
      Value<String> id,
      Value<String> teamId,
      Value<String> orderId,
      Value<LedgerEventType> type,
      Value<String> actorId,
      Value<DateTime> at,
      Value<String?> debtId,
      Value<String?> paymentId,
      Value<int?> amountBeforeCents,
      Value<int?> amountAfterCents,
      Value<String?> note,
      Value<List<String>> partyIds,
      Value<int> rowid,
    });

class $$LedgerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LedgerEventType, LedgerEventType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get actorId => $composableBuilder(
    column: $table.actorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get debtId => $composableBuilder(
    column: $table.debtId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentId => $composableBuilder(
    column: $table.paymentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountBeforeCents => $composableBuilder(
    column: $table.amountBeforeCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountAfterCents => $composableBuilder(
    column: $table.amountAfterCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get partyIds => $composableBuilder(
    column: $table.partyIds,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$LedgerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorId => $composableBuilder(
    column: $table.actorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get at => $composableBuilder(
    column: $table.at,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get debtId => $composableBuilder(
    column: $table.debtId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentId => $composableBuilder(
    column: $table.paymentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountBeforeCents => $composableBuilder(
    column: $table.amountBeforeCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountAfterCents => $composableBuilder(
    column: $table.amountAfterCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partyIds => $composableBuilder(
    column: $table.partyIds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LedgerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LedgerEntriesTable> {
  $$LedgerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LedgerEventType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get actorId =>
      $composableBuilder(column: $table.actorId, builder: (column) => column);

  GeneratedColumn<DateTime> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<String> get debtId =>
      $composableBuilder(column: $table.debtId, builder: (column) => column);

  GeneratedColumn<String> get paymentId =>
      $composableBuilder(column: $table.paymentId, builder: (column) => column);

  GeneratedColumn<int> get amountBeforeCents => $composableBuilder(
    column: $table.amountBeforeCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountAfterCents => $composableBuilder(
    column: $table.amountAfterCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get partyIds =>
      $composableBuilder(column: $table.partyIds, builder: (column) => column);
}

class $$LedgerEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LedgerEntriesTable,
          LedgerRow,
          $$LedgerEntriesTableFilterComposer,
          $$LedgerEntriesTableOrderingComposer,
          $$LedgerEntriesTableAnnotationComposer,
          $$LedgerEntriesTableCreateCompanionBuilder,
          $$LedgerEntriesTableUpdateCompanionBuilder,
          (
            LedgerRow,
            BaseReferences<_$AppDatabase, $LedgerEntriesTable, LedgerRow>,
          ),
          LedgerRow,
          PrefetchHooks Function()
        > {
  $$LedgerEntriesTableTableManager(_$AppDatabase db, $LedgerEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LedgerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LedgerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LedgerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<LedgerEventType> type = const Value.absent(),
                Value<String> actorId = const Value.absent(),
                Value<DateTime> at = const Value.absent(),
                Value<String?> debtId = const Value.absent(),
                Value<String?> paymentId = const Value.absent(),
                Value<int?> amountBeforeCents = const Value.absent(),
                Value<int?> amountAfterCents = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<List<String>> partyIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LedgerEntriesCompanion(
                id: id,
                teamId: teamId,
                orderId: orderId,
                type: type,
                actorId: actorId,
                at: at,
                debtId: debtId,
                paymentId: paymentId,
                amountBeforeCents: amountBeforeCents,
                amountAfterCents: amountAfterCents,
                note: note,
                partyIds: partyIds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String teamId,
                required String orderId,
                required LedgerEventType type,
                required String actorId,
                required DateTime at,
                Value<String?> debtId = const Value.absent(),
                Value<String?> paymentId = const Value.absent(),
                Value<int?> amountBeforeCents = const Value.absent(),
                Value<int?> amountAfterCents = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required List<String> partyIds,
                Value<int> rowid = const Value.absent(),
              }) => LedgerEntriesCompanion.insert(
                id: id,
                teamId: teamId,
                orderId: orderId,
                type: type,
                actorId: actorId,
                at: at,
                debtId: debtId,
                paymentId: paymentId,
                amountBeforeCents: amountBeforeCents,
                amountAfterCents: amountAfterCents,
                note: note,
                partyIds: partyIds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LedgerEntriesTable, LedgerRow>(table),
                  BaseReferences<_$AppDatabase, $LedgerEntriesTable, LedgerRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LedgerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LedgerEntriesTable,
      LedgerRow,
      $$LedgerEntriesTableFilterComposer,
      $$LedgerEntriesTableOrderingComposer,
      $$LedgerEntriesTableAnnotationComposer,
      $$LedgerEntriesTableCreateCompanionBuilder,
      $$LedgerEntriesTableUpdateCompanionBuilder,
      (
        LedgerRow,
        BaseReferences<_$AppDatabase, $LedgerEntriesTable, LedgerRow>,
      ),
      LedgerRow,
      PrefetchHooks Function()
    >;
typedef $$NoticeRecordsTableCreateCompanionBuilder =
    NoticeRecordsCompanion Function({
      required String id,
      required String teamId,
      required String senderId,
      required List<String> recipientIds,
      Value<NoticeTemplate?> template,
      Value<String?> customText,
      required DateTime sentAt,
      Value<int> rowid,
    });
typedef $$NoticeRecordsTableUpdateCompanionBuilder =
    NoticeRecordsCompanion Function({
      Value<String> id,
      Value<String> teamId,
      Value<String> senderId,
      Value<List<String>> recipientIds,
      Value<NoticeTemplate?> template,
      Value<String?> customText,
      Value<DateTime> sentAt,
      Value<int> rowid,
    });

class $$NoticeRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $NoticeRecordsTable> {
  $$NoticeRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get recipientIds => $composableBuilder(
    column: $table.recipientIds,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<NoticeTemplate?, NoticeTemplate, String>
  get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get customText => $composableBuilder(
    column: $table.customText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NoticeRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $NoticeRecordsTable> {
  $$NoticeRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipientIds => $composableBuilder(
    column: $table.recipientIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customText => $composableBuilder(
    column: $table.customText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NoticeRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NoticeRecordsTable> {
  $$NoticeRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get recipientIds =>
      $composableBuilder(
        column: $table.recipientIds,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<NoticeTemplate?, String> get template =>
      $composableBuilder(column: $table.template, builder: (column) => column);

  GeneratedColumn<String> get customText => $composableBuilder(
    column: $table.customText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);
}

class $$NoticeRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NoticeRecordsTable,
          NoticeRecordRow,
          $$NoticeRecordsTableFilterComposer,
          $$NoticeRecordsTableOrderingComposer,
          $$NoticeRecordsTableAnnotationComposer,
          $$NoticeRecordsTableCreateCompanionBuilder,
          $$NoticeRecordsTableUpdateCompanionBuilder,
          (
            NoticeRecordRow,
            BaseReferences<_$AppDatabase, $NoticeRecordsTable, NoticeRecordRow>,
          ),
          NoticeRecordRow,
          PrefetchHooks Function()
        > {
  $$NoticeRecordsTableTableManager(_$AppDatabase db, $NoticeRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NoticeRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NoticeRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NoticeRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<List<String>> recipientIds = const Value.absent(),
                Value<NoticeTemplate?> template = const Value.absent(),
                Value<String?> customText = const Value.absent(),
                Value<DateTime> sentAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NoticeRecordsCompanion(
                id: id,
                teamId: teamId,
                senderId: senderId,
                recipientIds: recipientIds,
                template: template,
                customText: customText,
                sentAt: sentAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String teamId,
                required String senderId,
                required List<String> recipientIds,
                Value<NoticeTemplate?> template = const Value.absent(),
                Value<String?> customText = const Value.absent(),
                required DateTime sentAt,
                Value<int> rowid = const Value.absent(),
              }) => NoticeRecordsCompanion.insert(
                id: id,
                teamId: teamId,
                senderId: senderId,
                recipientIds: recipientIds,
                template: template,
                customText: customText,
                sentAt: sentAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NoticeRecordsTable, NoticeRecordRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NoticeRecordsTable,
                    NoticeRecordRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NoticeRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NoticeRecordsTable,
      NoticeRecordRow,
      $$NoticeRecordsTableFilterComposer,
      $$NoticeRecordsTableOrderingComposer,
      $$NoticeRecordsTableAnnotationComposer,
      $$NoticeRecordsTableCreateCompanionBuilder,
      $$NoticeRecordsTableUpdateCompanionBuilder,
      (
        NoticeRecordRow,
        BaseReferences<_$AppDatabase, $NoticeRecordsTable, NoticeRecordRow>,
      ),
      NoticeRecordRow,
      PrefetchHooks Function()
    >;
typedef $$InboxNotificationsTableCreateCompanionBuilder =
    InboxNotificationsCompanion Function({
      required String id,
      required String recipientId,
      required NotificationKind kind,
      required String actorId,
      required String teamId,
      required NotificationTargetType targetType,
      required String targetId,
      Value<int?> amountCents,
      Value<String?> concept,
      Value<int?> debtCount,
      Value<int?> rejectedCount,
      Value<String?> note,
      Value<String?> templateKey,
      required DateTime createdAt,
      Value<DateTime?> readAt,
      Value<int> rowid,
    });
typedef $$InboxNotificationsTableUpdateCompanionBuilder =
    InboxNotificationsCompanion Function({
      Value<String> id,
      Value<String> recipientId,
      Value<NotificationKind> kind,
      Value<String> actorId,
      Value<String> teamId,
      Value<NotificationTargetType> targetType,
      Value<String> targetId,
      Value<int?> amountCents,
      Value<String?> concept,
      Value<int?> debtCount,
      Value<int?> rejectedCount,
      Value<String?> note,
      Value<String?> templateKey,
      Value<DateTime> createdAt,
      Value<DateTime?> readAt,
      Value<int> rowid,
    });

class $$InboxNotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $InboxNotificationsTable> {
  $$InboxNotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<NotificationKind, NotificationKind, String>
  get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get actorId => $composableBuilder(
    column: $table.actorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    NotificationTargetType,
    NotificationTargetType,
    String
  >
  get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concept => $composableBuilder(
    column: $table.concept,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get debtCount => $composableBuilder(
    column: $table.debtCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rejectedCount => $composableBuilder(
    column: $table.rejectedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateKey => $composableBuilder(
    column: $table.templateKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InboxNotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $InboxNotificationsTable> {
  $$InboxNotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorId => $composableBuilder(
    column: $table.actorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concept => $composableBuilder(
    column: $table.concept,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get debtCount => $composableBuilder(
    column: $table.debtCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rejectedCount => $composableBuilder(
    column: $table.rejectedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateKey => $composableBuilder(
    column: $table.templateKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InboxNotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InboxNotificationsTable> {
  $$InboxNotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recipientId => $composableBuilder(
    column: $table.recipientId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<NotificationKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get actorId =>
      $composableBuilder(column: $table.actorId, builder: (column) => column);

  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NotificationTargetType, String>
  get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetId =>
      $composableBuilder(column: $table.targetId, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get concept =>
      $composableBuilder(column: $table.concept, builder: (column) => column);

  GeneratedColumn<int> get debtCount =>
      $composableBuilder(column: $table.debtCount, builder: (column) => column);

  GeneratedColumn<int> get rejectedCount => $composableBuilder(
    column: $table.rejectedCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get templateKey => $composableBuilder(
    column: $table.templateKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get readAt =>
      $composableBuilder(column: $table.readAt, builder: (column) => column);
}

class $$InboxNotificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InboxNotificationsTable,
          InboxNotificationRow,
          $$InboxNotificationsTableFilterComposer,
          $$InboxNotificationsTableOrderingComposer,
          $$InboxNotificationsTableAnnotationComposer,
          $$InboxNotificationsTableCreateCompanionBuilder,
          $$InboxNotificationsTableUpdateCompanionBuilder,
          (
            InboxNotificationRow,
            BaseReferences<
              _$AppDatabase,
              $InboxNotificationsTable,
              InboxNotificationRow
            >,
          ),
          InboxNotificationRow,
          PrefetchHooks Function()
        > {
  $$InboxNotificationsTableTableManager(
    _$AppDatabase db,
    $InboxNotificationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InboxNotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InboxNotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InboxNotificationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> recipientId = const Value.absent(),
                Value<NotificationKind> kind = const Value.absent(),
                Value<String> actorId = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<NotificationTargetType> targetType = const Value.absent(),
                Value<String> targetId = const Value.absent(),
                Value<int?> amountCents = const Value.absent(),
                Value<String?> concept = const Value.absent(),
                Value<int?> debtCount = const Value.absent(),
                Value<int?> rejectedCount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> templateKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> readAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InboxNotificationsCompanion(
                id: id,
                recipientId: recipientId,
                kind: kind,
                actorId: actorId,
                teamId: teamId,
                targetType: targetType,
                targetId: targetId,
                amountCents: amountCents,
                concept: concept,
                debtCount: debtCount,
                rejectedCount: rejectedCount,
                note: note,
                templateKey: templateKey,
                createdAt: createdAt,
                readAt: readAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String recipientId,
                required NotificationKind kind,
                required String actorId,
                required String teamId,
                required NotificationTargetType targetType,
                required String targetId,
                Value<int?> amountCents = const Value.absent(),
                Value<String?> concept = const Value.absent(),
                Value<int?> debtCount = const Value.absent(),
                Value<int?> rejectedCount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> templateKey = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> readAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InboxNotificationsCompanion.insert(
                id: id,
                recipientId: recipientId,
                kind: kind,
                actorId: actorId,
                teamId: teamId,
                targetType: targetType,
                targetId: targetId,
                amountCents: amountCents,
                concept: concept,
                debtCount: debtCount,
                rejectedCount: rejectedCount,
                note: note,
                templateKey: templateKey,
                createdAt: createdAt,
                readAt: readAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InboxNotificationsTable, InboxNotificationRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $InboxNotificationsTable,
                    InboxNotificationRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InboxNotificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InboxNotificationsTable,
      InboxNotificationRow,
      $$InboxNotificationsTableFilterComposer,
      $$InboxNotificationsTableOrderingComposer,
      $$InboxNotificationsTableAnnotationComposer,
      $$InboxNotificationsTableCreateCompanionBuilder,
      $$InboxNotificationsTableUpdateCompanionBuilder,
      (
        InboxNotificationRow,
        BaseReferences<
          _$AppDatabase,
          $InboxNotificationsTable,
          InboxNotificationRow
        >,
      ),
      InboxNotificationRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OutboxEntriesTableTableManager get outboxEntries =>
      $$OutboxEntriesTableTableManager(_db, _db.outboxEntries);
  $$TeamsTableTableManager get teams =>
      $$TeamsTableTableManager(_db, _db.teams);
  $$TeamMembersTableTableManager get teamMembers =>
      $$TeamMembersTableTableManager(_db, _db.teamMembers);
  $$PayoutMethodsTableTableManager get payoutMethods =>
      $$PayoutMethodsTableTableManager(_db, _db.payoutMethods);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db, _db.debts);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$LedgerEntriesTableTableManager get ledgerEntries =>
      $$LedgerEntriesTableTableManager(_db, _db.ledgerEntries);
  $$NoticeRecordsTableTableManager get noticeRecords =>
      $$NoticeRecordsTableTableManager(_db, _db.noticeRecords);
  $$InboxNotificationsTableTableManager get inboxNotifications =>
      $$InboxNotificationsTableTableManager(_db, _db.inboxNotifications);
}
