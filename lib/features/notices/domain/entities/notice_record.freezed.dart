// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoticeRecord {

 String get id; String get senderId; String get teamId; List<String> get recipientIds; NoticeContent get content; DateTime get sentAt;
/// Create a copy of NoticeRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeRecordCopyWith<NoticeRecord> get copyWith => _$NoticeRecordCopyWithImpl<NoticeRecord>(this as NoticeRecord, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NoticeRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeRecord&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.senderId, _this.senderId) || other.senderId == _this.senderId)&&(identical(other.teamId, _this.teamId) || other.teamId == _this.teamId)&&const DeepCollectionEquality().equals(other.recipientIds, _this.recipientIds)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt));
}


@override
int get hashCode {
  final _this = this as NoticeRecord;
  return Object.hash(runtimeType,_this.id,_this.senderId,_this.teamId,const DeepCollectionEquality().hash(_this.recipientIds),_this.content,_this.sentAt);
}

@override
String toString() {
  final _this = this as NoticeRecord;
  return 'NoticeRecord(id: ${_this.id}, senderId: ${_this.senderId}, teamId: ${_this.teamId}, recipientIds: ${_this.recipientIds}, content: ${_this.content}, sentAt: ${_this.sentAt})';
}


}

/// @nodoc
abstract mixin class $NoticeRecordCopyWith<$Res>  {
  factory $NoticeRecordCopyWith(NoticeRecord value, $Res Function(NoticeRecord) _then) = _$NoticeRecordCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String teamId, List<String> recipientIds, NoticeContent content, DateTime sentAt
});




}
/// @nodoc
class _$NoticeRecordCopyWithImpl<$Res>
    implements $NoticeRecordCopyWith<$Res> {
  _$NoticeRecordCopyWithImpl(this._self, this._then);

  final NoticeRecord _self;
  final $Res Function(NoticeRecord) _then;

/// Create a copy of NoticeRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? teamId = null,Object? recipientIds = null,Object? content = null,Object? sentAt = null,}) {
  return _then(NoticeRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,recipientIds: null == recipientIds ? _self.recipientIds : recipientIds // ignore: cast_nullable_to_non_nullable
as List<String>,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as NoticeContent,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeRecord].
extension NoticeRecordPatterns on NoticeRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeRecord value)  $default,){
final _that = this;
switch (_that) {
case _NoticeRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeRecord value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String teamId,  List<String> recipientIds,  NoticeContent content,  DateTime sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeRecord() when $default != null:
return $default(_that.id,_that.senderId,_that.teamId,_that.recipientIds,_that.content,_that.sentAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String teamId,  List<String> recipientIds,  NoticeContent content,  DateTime sentAt)  $default,) {final _that = this;
switch (_that) {
case _NoticeRecord():
return $default(_that.id,_that.senderId,_that.teamId,_that.recipientIds,_that.content,_that.sentAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String teamId,  List<String> recipientIds,  NoticeContent content,  DateTime sentAt)?  $default,) {final _that = this;
switch (_that) {
case _NoticeRecord() when $default != null:
return $default(_that.id,_that.senderId,_that.teamId,_that.recipientIds,_that.content,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc


class _NoticeRecord implements NoticeRecord {
  const _NoticeRecord({required this.id, required this.senderId, required this.teamId, required  List<String> recipientIds, required this.content, required this.sentAt}): _recipientIds = recipientIds;
  

@override final  String id;
@override final  String senderId;
@override final  String teamId;
 final  List<String> _recipientIds;
@override List<String> get recipientIds {
  if (_recipientIds is EqualUnmodifiableListView) return _recipientIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recipientIds);
}

@override final  NoticeContent content;
@override final  DateTime sentAt;

/// Create a copy of NoticeRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeRecordCopyWith<_NoticeRecord> get copyWith => __$NoticeRecordCopyWithImpl<_NoticeRecord>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&const DeepCollectionEquality().equals(other.recipientIds, _recipientIds)&&(identical(other.content, content) || other.content == content)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,senderId,teamId,const DeepCollectionEquality().hash(_recipientIds),content,sentAt);
}

@override
String toString() {
    return 'NoticeRecord(id: $id, senderId: $senderId, teamId: $teamId, recipientIds: $recipientIds, content: $content, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$NoticeRecordCopyWith<$Res> implements $NoticeRecordCopyWith<$Res> {
  factory _$NoticeRecordCopyWith(_NoticeRecord value, $Res Function(_NoticeRecord) _then) = __$NoticeRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String teamId, List<String> recipientIds, NoticeContent content, DateTime sentAt
});




}
/// @nodoc
class __$NoticeRecordCopyWithImpl<$Res>
    implements _$NoticeRecordCopyWith<$Res> {
  __$NoticeRecordCopyWithImpl(this._self, this._then);

  final _NoticeRecord _self;
  final $Res Function(_NoticeRecord) _then;

/// Create a copy of NoticeRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? teamId = null,Object? recipientIds = null,Object? content = null,Object? sentAt = null,}) {
  return _then(_NoticeRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,recipientIds: null == recipientIds ? _self._recipientIds : recipientIds // ignore: cast_nullable_to_non_nullable
as List<String>,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as NoticeContent,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
