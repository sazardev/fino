import 'package:drift/drift.dart';

import '../../../../core/database/converters/string_list_converter.dart';
import '../../domain/enums/notice_template.dart';

/// Registro de avisos enviados por este usuario (SPEC A5).
@DataClassName('NoticeRecordRow')
@TableIndex(
  name: 'notice_records_sender',
  columns: {#senderId, #teamId, #sentAt},
)
class NoticeRecords extends Table {
  TextColumn get id => text()();
  TextColumn get teamId => text()();
  TextColumn get senderId => text()();
  TextColumn get recipientIds => text().map(const StringListConverter())();
  TextColumn get template => textEnum<NoticeTemplate>().nullable()();
  TextColumn get customText => text().nullable()();
  DateTimeColumn get sentAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
