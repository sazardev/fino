// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LedgerEntry {

 String get id; String get orderId; LedgerEventType get type; String get actorId; DateTime get at; String? get debtId; String? get paymentId; Money? get amountBefore; Money? get amountAfter; String? get note;
/// Create a copy of LedgerEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerEntryCopyWith<LedgerEntry> get copyWith => _$LedgerEntryCopyWithImpl<LedgerEntry>(this as LedgerEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LedgerEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.actorId, _this.actorId) || other.actorId == _this.actorId)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.debtId, _this.debtId) || other.debtId == _this.debtId)&&(identical(other.paymentId, _this.paymentId) || other.paymentId == _this.paymentId)&&(identical(other.amountBefore, _this.amountBefore) || other.amountBefore == _this.amountBefore)&&(identical(other.amountAfter, _this.amountAfter) || other.amountAfter == _this.amountAfter)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as LedgerEntry;
  return Object.hash(runtimeType,_this.id,_this.orderId,_this.type,_this.actorId,_this.at,_this.debtId,_this.paymentId,_this.amountBefore,_this.amountAfter,_this.note);
}

@override
String toString() {
  final _this = this as LedgerEntry;
  return 'LedgerEntry(id: ${_this.id}, orderId: ${_this.orderId}, type: ${_this.type}, actorId: ${_this.actorId}, at: ${_this.at}, debtId: ${_this.debtId}, paymentId: ${_this.paymentId}, amountBefore: ${_this.amountBefore}, amountAfter: ${_this.amountAfter}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $LedgerEntryCopyWith<$Res>  {
  factory $LedgerEntryCopyWith(LedgerEntry value, $Res Function(LedgerEntry) _then) = _$LedgerEntryCopyWithImpl;
@useResult
$Res call({
 String id, String orderId, LedgerEventType type, String actorId, DateTime at, String? debtId, String? paymentId, Money? amountBefore, Money? amountAfter, String? note
});




}
/// @nodoc
class _$LedgerEntryCopyWithImpl<$Res>
    implements $LedgerEntryCopyWith<$Res> {
  _$LedgerEntryCopyWithImpl(this._self, this._then);

  final LedgerEntry _self;
  final $Res Function(LedgerEntry) _then;

/// Create a copy of LedgerEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? type = null,Object? actorId = null,Object? at = null,Object? debtId = freezed,Object? paymentId = freezed,Object? amountBefore = freezed,Object? amountAfter = freezed,Object? note = freezed,}) {
  return _then(LedgerEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LedgerEventType,actorId: null == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,debtId: freezed == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as String?,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,amountBefore: freezed == amountBefore ? _self.amountBefore : amountBefore // ignore: cast_nullable_to_non_nullable
as Money?,amountAfter: freezed == amountAfter ? _self.amountAfter : amountAfter // ignore: cast_nullable_to_non_nullable
as Money?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerEntry].
extension LedgerEntryPatterns on LedgerEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerEntry value)  $default,){
final _that = this;
switch (_that) {
case _LedgerEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerEntry value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderId,  LedgerEventType type,  String actorId,  DateTime at,  String? debtId,  String? paymentId,  Money? amountBefore,  Money? amountAfter,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerEntry() when $default != null:
return $default(_that.id,_that.orderId,_that.type,_that.actorId,_that.at,_that.debtId,_that.paymentId,_that.amountBefore,_that.amountAfter,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderId,  LedgerEventType type,  String actorId,  DateTime at,  String? debtId,  String? paymentId,  Money? amountBefore,  Money? amountAfter,  String? note)  $default,) {final _that = this;
switch (_that) {
case _LedgerEntry():
return $default(_that.id,_that.orderId,_that.type,_that.actorId,_that.at,_that.debtId,_that.paymentId,_that.amountBefore,_that.amountAfter,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderId,  LedgerEventType type,  String actorId,  DateTime at,  String? debtId,  String? paymentId,  Money? amountBefore,  Money? amountAfter,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _LedgerEntry() when $default != null:
return $default(_that.id,_that.orderId,_that.type,_that.actorId,_that.at,_that.debtId,_that.paymentId,_that.amountBefore,_that.amountAfter,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerEntry implements LedgerEntry {
  const _LedgerEntry({required this.id, required this.orderId, required this.type, required this.actorId, required this.at, this.debtId, this.paymentId, this.amountBefore, this.amountAfter, this.note});
  

@override final  String id;
@override final  String orderId;
@override final  LedgerEventType type;
@override final  String actorId;
@override final  DateTime at;
@override final  String? debtId;
@override final  String? paymentId;
@override final  Money? amountBefore;
@override final  Money? amountAfter;
@override final  String? note;

/// Create a copy of LedgerEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerEntryCopyWith<_LedgerEntry> get copyWith => __$LedgerEntryCopyWithImpl<_LedgerEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.type, type) || other.type == type)&&(identical(other.actorId, actorId) || other.actorId == actorId)&&(identical(other.at, at) || other.at == at)&&(identical(other.debtId, debtId) || other.debtId == debtId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.amountBefore, amountBefore) || other.amountBefore == amountBefore)&&(identical(other.amountAfter, amountAfter) || other.amountAfter == amountAfter)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,orderId,type,actorId,at,debtId,paymentId,amountBefore,amountAfter,note);
}

@override
String toString() {
    return 'LedgerEntry(id: $id, orderId: $orderId, type: $type, actorId: $actorId, at: $at, debtId: $debtId, paymentId: $paymentId, amountBefore: $amountBefore, amountAfter: $amountAfter, note: $note)';
}


}

/// @nodoc
abstract mixin class _$LedgerEntryCopyWith<$Res> implements $LedgerEntryCopyWith<$Res> {
  factory _$LedgerEntryCopyWith(_LedgerEntry value, $Res Function(_LedgerEntry) _then) = __$LedgerEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId, LedgerEventType type, String actorId, DateTime at, String? debtId, String? paymentId, Money? amountBefore, Money? amountAfter, String? note
});




}
/// @nodoc
class __$LedgerEntryCopyWithImpl<$Res>
    implements _$LedgerEntryCopyWith<$Res> {
  __$LedgerEntryCopyWithImpl(this._self, this._then);

  final _LedgerEntry _self;
  final $Res Function(_LedgerEntry) _then;

/// Create a copy of LedgerEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? type = null,Object? actorId = null,Object? at = null,Object? debtId = freezed,Object? paymentId = freezed,Object? amountBefore = freezed,Object? amountAfter = freezed,Object? note = freezed,}) {
  return _then(_LedgerEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LedgerEventType,actorId: null == actorId ? _self.actorId : actorId // ignore: cast_nullable_to_non_nullable
as String,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,debtId: freezed == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as String?,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,amountBefore: freezed == amountBefore ? _self.amountBefore : amountBefore // ignore: cast_nullable_to_non_nullable
as Money?,amountAfter: freezed == amountAfter ? _self.amountAfter : amountAfter // ignore: cast_nullable_to_non_nullable
as Money?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
