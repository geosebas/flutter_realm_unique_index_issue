// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class SomeEvent extends $SomeEvent
    with RealmEntity, RealmObjectBase, RealmObject {
  SomeEvent(
    String id,
    String groupId,
    DateTime date,
    int slot,
    String info,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'groupId', groupId);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'slot', slot);
    RealmObjectBase.set(this, 'info', info);
  }

  SomeEvent._();

  @override
  String get id => RealmObjectBase.get<String>(this, '_id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get groupId => RealmObjectBase.get<String>(this, 'groupId') as String;
  @override
  set groupId(String value) => RealmObjectBase.set(this, 'groupId', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  int get slot => RealmObjectBase.get<int>(this, 'slot') as int;
  @override
  set slot(int value) => RealmObjectBase.set(this, 'slot', value);

  @override
  String get info => RealmObjectBase.get<String>(this, 'info') as String;
  @override
  set info(String value) => RealmObjectBase.set(this, 'info', value);

  @override
  Stream<RealmObjectChanges<SomeEvent>> get changes =>
      RealmObjectBase.getChanges<SomeEvent>(this);

  @override
  SomeEvent freeze() => RealmObjectBase.freezeObject<SomeEvent>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(SomeEvent._);
    return const SchemaObject(ObjectType.realmObject, SomeEvent, 'SomeEvent', [
      SchemaProperty('id', RealmPropertyType.string,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('groupId', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('slot', RealmPropertyType.int),
      SchemaProperty('info', RealmPropertyType.string),
    ]);
  }
}
