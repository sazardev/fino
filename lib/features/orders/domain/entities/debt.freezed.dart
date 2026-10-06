// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Debt {

 String get id; String get orderId; String get teamId; String get creditorId; String get debtorId; Money get amount; DebtStatus get status; DateTime get createdAt; DateTime get updatedAt; String? get paymentId;
/// Create a copy of Debt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtCopyWith<Debt> get copyWith => _$DebtCopyWithImpl<Debt>(this as Debt, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Debt;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Debt&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.teamId, _this.teamId) || other.teamId == _this.teamId)&&(identical(other.creditorId, _this.creditorId) || other.creditorId == _this.creditorId)&&(identical(other.debtorId, _this.debtorId) || other.debtorId == _this.debtorId)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.paymentId, _this.paymentId) || other.paymentId == _this.paymentId));
}


@override
int get hashCode {
  final _this = this as Debt;
  return Object.hash(runtimeType,_this.id,_this.orderId,_this.teamId,_this.creditorId,_this.debtorId,_this.amount,_this.status,_this.createdAt,_this.updatedAt,_this.paymentId);
}

@override
String toString() {
  final _this = this as Debt;
  return 'Debt(id: ${_this.id}, orderId: ${_this.orderId}, teamId: ${_this.teamId}, creditorId: ${_this.creditorId}, debtorId: ${_this.debtorId}, amount: ${_this.amount}, status: ${_this.status}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, paymentId: ${_this.paymentId})';
}


}

/// @nodoc
abstract mixin class $DebtCopyWith<$Res>  {
  factory $DebtCopyWith(Debt value, $Res Function(Debt) _then) = _$DebtCopyWithImpl;
@useResult
$Res call({
 String id, String orderId, String teamId, String creditorId, String debtorId, Money amount, DebtStatus status, DateTime createdAt, DateTime updatedAt, String? paymentId
});




}
/// @nodoc
class _$DebtCopyWithImpl<$Res>
    implements $DebtCopyWith<$Res> {
  _$DebtCopyWithImpl(this._self, this._then);

  final Debt _self;
  final $Res Function(Debt) _then;

/// Create a copy of Debt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? teamId = null,Object? creditorId = null,Object? debtorId = null,Object? amount = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? paymentId = freezed,}) {
  return _then(Debt(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,creditorId: null == creditorId ? _self.creditorId : creditorId // ignore: cast_nullable_to_non_nullable
as String,debtorId: null == debtorId ? _self.debtorId : debtorId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Debt].
extension DebtPatterns on Debt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Debt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Debt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Debt value)  $default,){
final _that = this;
switch (_that) {
case _Debt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Debt value)?  $default,){
final _that = this;
switch (_that) {
case _Debt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderId,  String teamId,  String creditorId,  String debtorId,  Money amount,  DebtStatus status,  DateTime createdAt,  DateTime updatedAt,  String? paymentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Debt() when $default != null:
return $default(_that.id,_that.orderId,_that.teamId,_that.creditorId,_that.debtorId,_that.amount,_that.status,_that.createdAt,_that.updatedAt,_that.paymentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderId,  String teamId,  String creditorId,  String debtorId,  Money amount,  DebtStatus status,  DateTime createdAt,  DateTime updatedAt,  String? paymentId)  $default,) {final _that = this;
switch (_that) {
case _Debt():
return $default(_that.id,_that.orderId,_that.teamId,_that.creditorId,_that.debtorId,_that.amount,_that.status,_that.createdAt,_that.updatedAt,_that.paymentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderId,  String teamId,  String creditorId,  String debtorId,  Money amount,  DebtStatus status,  DateTime createdAt,  DateTime updatedAt,  String? paymentId)?  $default,) {final _that = this;
switch (_that) {
case _Debt() when $default != null:
return $default(_that.id,_that.orderId,_that.teamId,_that.creditorId,_that.debtorId,_that.amount,_that.status,_that.createdAt,_that.updatedAt,_that.paymentId);case _:
  return null;

}
}

}

/// @nodoc


class _Debt implements Debt {
  const _Debt({required this.id, required this.orderId, required this.teamId, required this.creditorId, required this.debtorId, required this.amount, required this.status, required this.createdAt, required this.updatedAt, this.paymentId});
  

@override final  String id;
@override final  String orderId;
@override final  String teamId;
@override final  String creditorId;
@override final  String debtorId;
@override final  Money amount;
@override final  DebtStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? paymentId;

/// Create a copy of Debt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtCopyWith<_Debt> get copyWith => __$DebtCopyWithImpl<_Debt>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Debt&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.creditorId, creditorId) || other.creditorId == creditorId)&&(identical(other.debtorId, debtorId) || other.debtorId == debtorId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,orderId,teamId,creditorId,debtorId,amount,status,createdAt,updatedAt,paymentId);
}

@override
String toString() {
    return 'Debt(id: $id, orderId: $orderId, teamId: $teamId, creditorId: $creditorId, debtorId: $debtorId, amount: $amount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class _$DebtCopyWith<$Res> implements $DebtCopyWith<$Res> {
  factory _$DebtCopyWith(_Debt value, $Res Function(_Debt) _then) = __$DebtCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId, String teamId, String creditorId, String debtorId, Money amount, DebtStatus status, DateTime createdAt, DateTime updatedAt, String? paymentId
});




}
/// @nodoc
class __$DebtCopyWithImpl<$Res>
    implements _$DebtCopyWith<$Res> {
  __$DebtCopyWithImpl(this._self, this._then);

  final _Debt _self;
  final $Res Function(_Debt) _then;

/// Create a copy of Debt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? teamId = null,Object? creditorId = null,Object? debtorId = null,Object? amount = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? paymentId = freezed,}) {
  return _then(_Debt(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,creditorId: null == creditorId ? _self.creditorId : creditorId // ignore: cast_nullable_to_non_nullable
as String,debtorId: null == debtorId ? _self.debtorId : debtorId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as Money,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DebtStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
