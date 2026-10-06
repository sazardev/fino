// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_records_dao.dart';

// ignore_for_file: type=lint
mixin _$NoticeRecordsDaoMixin on DatabaseAccessor<AppDatabase> {
  $NoticeRecordsTable get noticeRecords => attachedDatabase.noticeRecords;
  NoticeRecordsDaoManager get managers => NoticeRecordsDaoManager(this);
}

class NoticeRecordsDaoManager {
  final _$NoticeRecordsDaoMixin _db;
  NoticeRecordsDaoManager(this._db);
  $$NoticeRecordsTableTableManager get noticeRecords =>
      $$NoticeRecordsTableTableManager(_db.attachedDatabase, _db.noticeRecords);
}
