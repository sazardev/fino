// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InboxNotification {

 String get id; NotificationIntent get intent; DateTime get createdAt; DateTime? get readAt;
/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxNotificationCopyWith<InboxNotification> get copyWith => _$InboxNotificationCopyWithImpl<InboxNotification>(this as InboxNotification, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InboxNotification;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxNotification&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.intent, _this.intent) || other.intent == _this.intent)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.readAt, _this.readAt) || other.readAt == _this.readAt));
}


@override
int get hashCode {
  final _this = this as InboxNotification;
  return Object.hash(runtimeType,_this.id,_this.intent,_this.createdAt,_this.readAt);
}

@override
String toString() {
  final _this = this as InboxNotification;
  return 'InboxNotification(id: ${_this.id}, intent: ${_this.intent}, createdAt: ${_this.createdAt}, readAt: ${_this.readAt})';
}


}

/// @nodoc
abstract mixin class $InboxNotificationCopyWith<$Res>  {
  factory $InboxNotificationCopyWith(InboxNotification value, $Res Function(InboxNotification) _then) = _$InboxNotificationCopyWithImpl;
@useResult
$Res call({
 String id, NotificationIntent intent, DateTime createdAt, DateTime? readAt
});


$NotificationIntentCopyWith<$Res> get intent;

}
/// @nodoc
class _$InboxNotificationCopyWithImpl<$Res>
    implements $InboxNotificationCopyWith<$Res> {
  _$InboxNotificationCopyWithImpl(this._self, this._then);

  final InboxNotification _self;
  final $Res Function(InboxNotification) _then;

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? intent = null,Object? createdAt = null,Object? readAt = freezed,}) {
  return _then(InboxNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as NotificationIntent,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationIntentCopyWith<$Res> get intent {
  
  return $NotificationIntentCopyWith<$Res>(_self.intent, (value) {
    return _then(_self.copyWith(intent: value));
  });
}
}


/// Adds pattern-matching-related methods to [InboxNotification].
extension InboxNotificationPatterns on InboxNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InboxNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InboxNotification value)  $default,){
final _that = this;
switch (_that) {
case _InboxNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InboxNotification value)?  $default,){
final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  NotificationIntent intent,  DateTime createdAt,  DateTime? readAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
return $default(_that.id,_that.intent,_that.createdAt,_that.readAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  NotificationIntent intent,  DateTime createdAt,  DateTime? readAt)  $default,) {final _that = this;
switch (_that) {
case _InboxNotification():
return $default(_that.id,_that.intent,_that.createdAt,_that.readAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  NotificationIntent intent,  DateTime createdAt,  DateTime? readAt)?  $default,) {final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
return $default(_that.id,_that.intent,_that.createdAt,_that.readAt);case _:
  return null;

}
}

}

/// @nodoc


class _InboxNotification implements InboxNotification {
  const _InboxNotification({required this.id, required this.intent, required this.createdAt, this.readAt});
  

@override final  String id;
@override final  NotificationIntent intent;
@override final  DateTime createdAt;
@override final  DateTime? readAt;

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxNotificationCopyWith<_InboxNotification> get copyWith => __$InboxNotificationCopyWithImpl<_InboxNotification>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.intent, intent) || other.intent == intent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.readAt, readAt) || other.readAt == readAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,intent,createdAt,readAt);
}

@override
String toString() {
    return 'InboxNotification(id: $id, intent: $intent, createdAt: $createdAt, readAt: $readAt)';
}


}

/// @nodoc
abstract mixin class _$InboxNotificationCopyWith<$Res> implements $InboxNotificationCopyWith<$Res> {
  factory _$InboxNotificationCopyWith(_InboxNotification value, $Res Function(_InboxNotification) _then) = __$InboxNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, NotificationIntent intent, DateTime createdAt, DateTime? readAt
});


@override $NotificationIntentCopyWith<$Res> get intent;

}
/// @nodoc
class __$InboxNotificationCopyWithImpl<$Res>
    implements _$InboxNotificationCopyWith<$Res> {
  __$InboxNotificationCopyWithImpl(this._self, this._then);

  final _InboxNotification _self;
  final $Res Function(_InboxNotification) _then;

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? intent = null,Object? createdAt = null,Object? readAt = freezed,}) {
  return _then(_InboxNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,intent: null == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as NotificationIntent,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationIntentCopyWith<$Res> get intent {
  
  return $NotificationIntentCopyWith<$Res>(_self.intent, (value) {
    return _then(_self.copyWith(intent: value));
  });
}
}

// dart format on
