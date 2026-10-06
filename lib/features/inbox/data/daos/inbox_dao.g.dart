// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_dao.dart';

// ignore_for_file: type=lint
mixin _$InboxDaoMixin on DatabaseAccessor<AppDatabase> {
  $InboxNotificationsTable get inboxNotifications =>
      attachedDatabase.inboxNotifications;
  InboxDaoManager get managers => InboxDaoManager(this);
}

class InboxDaoManager {
  final _$InboxDaoMixin _db;
  InboxDaoManager(this._db);
  $$InboxNotificationsTableTableManager get inboxNotifications =>
      $$InboxNotificationsTableTableManager(
        _db.attachedDatabase,
        _db.inboxNotifications,
      );
}
