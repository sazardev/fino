// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_intent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationIntent {

 NotificationKind get kind; String get recipientId; String get actorId; String get teamId; NotificationTarget get target; Money? get amount; String? get concept; int? get debtCount; int? get rejectedCount; String? get note; String? get templateKey;
/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationIntentCopyWith<NotificationIntent> get copyWith => _$NotificationIntentCopyWithImpl<NotificationIntent>(this as NotificationIntent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NotificationIntent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationIntent&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.recipientId, _this.recipientId) || other.recipientId == _this.recipientId)&&(identical(other.actorId, _this.actorId) || other.actorId == _this.actorId)&&(identical(other.teamId, _this.teamId) || other.teamId == _this.teamId)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.concept, _this.concept) || other.concept == _this.concept)&&(identical(other.debtCount, _this.debtCount) || other.debtCount == _this.debtCount)&&(identical(other.rejectedCount, _this.rejectedCount) || other.rejectedCount == _this.rejectedCount)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.templateKey, _this.templateKey) || other.templateKey == _this.templateKey));
}


@override
int get hashCode {
  final _this = this as NotificationIntent;
  return Object.hash(runtimeType,_this.kind,_this.recipientId,_this.actorId,_this.teamId,_this.target,_this.amount,_this.concept,_this.debtCount,_this.rejectedCount,_this.note,_this.templateKey);
}

@override
String toString() {
  final _this = this as NotificationIntent;
  return 'NotificationIntent(kind: ${_this.kind}, recipientId: ${_this.recipientId}, actorId: ${_this.actorId}, teamId: ${_this.teamId}, target: ${_this.target}, amount: ${_this.amount}, concept: ${_this.concept}, debtCount: ${_this.debtCount}, rejectedCount: ${_this.rejectedCount}, note: ${_this.note}, templateKey: ${_this.templateKey})';
}


}

/// @nodoc
abstract mixin class $NotificationIntentCopyWith<$Res>  {
  factory $NotificationIntentCopyWith(NotificationIntent value, $Res Function(NotificationIntent) _then) = _$NotificationIntentCopyWithImpl;
@useResult
$Res call({
 NotificationKind kind, String recipientId, String actorId, String teamId, NotificationTarget target, Money? amount, String? concept, int? debtCount, int? rejectedCount, String? note, String? templateKey
});




}
/// @nodoc
class _$NotificationIntentCopyWithImpl<$Res>
    implements $NotificationIntentCopyWith<$Res> {
  _$NotificationIntentCopyWithImpl(this._self, this._then);

  final NotificationIntent _self;
  final $Res Function(NotificationIntent) _then;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? recipientId = null,Object? actorId = null,Object? teamId = null,Object? target = null,Object? amount = freezed,Object? concept = freezed,Object? debtCount = freezed,Object? rejectedCount = freezed,Object? note = freezed,Object? templateKey = freezed,}) {
  return _then(NotificationIntent(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NotificationKind,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,actorId: null == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as NotificationTarget,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money?,concept: freezed == concept ? _self.concept : concept // ignore: cast_nullable_to_non_nullable
as String?,debtCount: freezed == debtCount ? _self.debtCount : debtCount // ignore: cast_nullable_to_non_nullable
as int?,rejectedCount: freezed == rejectedCount ? _self.rejectedCount : rejectedCount // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,templateKey: freezed == templateKey ? _self.templateKey : templateKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationIntent].
extension NotificationIntentPatterns on NotificationIntent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationIntent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationIntent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationIntent value)  $default,){
final _that = this;
switch (_that) {
case _NotificationIntent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationIntent value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationIntent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotificationKind kind,  String recipientId,  String actorId,  String teamId,  NotificationTarget target,  Money? amount,  String? concept,  int? debtCount,  int? rejectedCount,  String? note,  String? templateKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationIntent() when $default != null:
return $default(_that.kind,_that.recipientId,_that.actorId,_that.teamId,_that.target,_that.amount,_that.concept,_that.debtCount,_that.rejectedCount,_that.note,_that.templateKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotificationKind kind,  String recipientId,  String actorId,  String teamId,  NotificationTarget target,  Money? amount,  String? concept,  int? debtCount,  int? rejectedCount,  String? note,  String? templateKey)  $default,) {final _that = this;
switch (_that) {
case _NotificationIntent():
return $default(_that.kind,_that.recipientId,_that.actorId,_that.teamId,_that.target,_that.amount,_that.concept,_that.debtCount,_that.rejectedCount,_that.note,_that.templateKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotificationKind kind,  String recipientId,  String actorId,  String teamId,  NotificationTarget target,  Money? amount,  String? concept,  int? debtCount,  int? rejectedCount,  String? note,  String? templateKey)?  $default,) {final _that = this;
switch (_that) {
case _NotificationIntent() when $default != null:
return $default(_that.kind,_that.recipientId,_that.actorId,_that.teamId,_that.target,_that.amount,_that.concept,_that.debtCount,_that.rejectedCount,_that.note,_that.templateKey);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationIntent implements NotificationIntent {
  const _NotificationIntent({required this.kind, required this.recipientId, required this.actorId, required this.teamId, required this.target, this.amount, this.concept, this.debtCount, this.rejectedCount, this.note, this.templateKey});
  

@override final  NotificationKind kind;
@override final  String recipientId;
@override final  String actorId;
@override final  String teamId;
@override final  NotificationTarget target;
@override final  Money? amount;
@override final  String? concept;
@override final  int? debtCount;
@override final  int? rejectedCount;
@override final  String? note;
@override final  String? templateKey;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationIntentCopyWith<_NotificationIntent> get copyWith => __$NotificationIntentCopyWithImpl<_NotificationIntent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationIntent&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.target, target) || other.target == target)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.concept, concept) || other.concept == concept)&&(identical(other.debtCount, debtCount) || other.debtCount == debtCount)&&(identical(other.rejectedCount, rejectedCount) || other.rejectedCount == rejectedCount)&&(identical(other.note, note) || other.note == note)&&(identical(other.templateKey, templateKey) || other.templateKey == templateKey));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,recipientId,actorId,teamId,target,amount,concept,debtCount,rejectedCount,note,templateKey);
}

@override
String toString() {
    return 'NotificationIntent(kind: $kind, recipientId: $recipientId, actorId: $actorId, teamId: $teamId, target: $target, amount: $amount, concept: $concept, debtCount: $debtCount, rejectedCount: $rejectedCount, note: $note, templateKey: $templateKey)';
}


}

/// @nodoc
abstract mixin class _$NotificationIntentCopyWith<$Res> implements $NotificationIntentCopyWith<$Res> {
  factory _$NotificationIntentCopyWith(_NotificationIntent value, $Res Function(_NotificationIntent) _then) = __$NotificationIntentCopyWithImpl;
@override @useResult
$Res call({
 NotificationKind kind, String recipientId, String actorId, String teamId, NotificationTarget target, Money? amount, String? concept, int? debtCount, int? rejectedCount, String? note, String? templateKey
});




}
/// @nodoc
class __$NotificationIntentCopyWithImpl<$Res>
    implements _$NotificationIntentCopyWith<$Res> {
  __$NotificationIntentCopyWithImpl(this._self, this._then);

  final _NotificationIntent _self;
  final $Res Function(_NotificationIntent) _then;

/// Create a copy of NotificationIntent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? recipientId = null,Object? actorId = null,Object? teamId = null,Object? target = null,Object? amount = freezed,Object? concept = freezed,Object? debtCount = freezed,Object? rejectedCount = freezed,Object? note = freezed,Object? templateKey = freezed,}) {
  return _then(_NotificationIntent(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NotificationKind,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,actorId: null == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as NotificationTarget,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money?,concept: freezed == concept ? _self.concept : concept // ignore: cast_nullable_to_non_nullable
as String?,debtCount: freezed == debtCount ? _self.debtCount : debtCount // ignore: cast_nullable_to_non_nullable
as int?,rejectedCount: freezed == rejectedCount ? _self.rejectedCount : rejectedCount // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,templateKey: freezed == templateKey ? _self.templateKey : templateKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
