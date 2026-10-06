// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Payment {

 String get id; String get teamId; String get creditorId; String get debtorId; List<String> get debtIds; PayoutSnapshot get payoutShown; DateTime get reportedAt; bool get awaitingConfirmationReminderSent; String? get reference;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Payment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.teamId, _this.teamId) || other.teamId == _this.teamId)&&(identical(other.creditorId, _this.creditorId) || other.creditorId == _this.creditorId)&&(identical(other.debtorId, _this.debtorId) || other.debtorId == _this.debtorId)&&const DeepCollectionEquality().equals(other.debtIds, _this.debtIds)&&(identical(other.payoutShown, _this.payoutShown) || other.payoutShown == _this.payoutShown)&&(identical(other.reportedAt, _this.reportedAt) || other.reportedAt == _this.reportedAt)&&(identical(other.awaitingConfirmationReminderSent, _this.awaitingConfirmationReminderSent) || other.awaitingConfirmationReminderSent == _this.awaitingConfirmationReminderSent)&&(identical(other.reference, _this.reference) || other.reference == _this.reference));
}


@override
int get hashCode {
  final _this = this as Payment;
  return Object.hash(runtimeType,_this.id,_this.teamId,_this.creditorId,_this.debtorId,const DeepCollectionEquality().hash(_this.debtIds),_this.payoutShown,_this.reportedAt,_this.awaitingConfirmationReminderSent,_this.reference);
}

@override
String toString() {
  final _this = this as Payment;
  return 'Payment(id: ${_this.id}, teamId: ${_this.teamId}, creditorId: ${_this.creditorId}, debtorId: ${_this.debtorId}, debtIds: ${_this.debtIds}, payoutShown: ${_this.payoutShown}, reportedAt: ${_this.reportedAt}, awaitingConfirmationReminderSent: ${_this.awaitingConfirmationReminderSent}, reference: ${_this.reference})';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String id, String teamId, String creditorId, String debtorId, List<String> debtIds, PayoutSnapshot payoutShown, DateTime reportedAt, bool awaitingConfirmationReminderSent, String? reference
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? teamId = null,Object? creditorId = null,Object? debtorId = null,Object? debtIds = null,Object? payoutShown = null,Object? reportedAt = null,Object? awaitingConfirmationReminderSent = null,Object? reference = freezed,}) {
  return _then(Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,creditorId: null == creditorId ? _self.creditorId : creditorId // ignore: cast_nullable_to_non_nullable
as String,debtorId: null == debtorId ? _self.debtorId : debtorId // ignore: cast_nullable_to_non_nullable
as String,debtIds: null == debtIds ? _self.debtIds : debtIds // ignore: cast_nullable_to_non_nullable
as List<String>,payoutShown: null == payoutShown ? _self.payoutShown : payoutShown // ignore: cast_nullable_to_non_nullable
as PayoutSnapshot,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,awaitingConfirmationReminderSent: null == awaitingConfirmationReminderSent ? _self.awaitingConfirmationReminderSent : awaitingConfirmationReminderSent // ignore: cast_nullable_to_non_nullable
as bool,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String teamId,  String creditorId,  String debtorId,  List<String> debtIds,  PayoutSnapshot payoutShown,  DateTime reportedAt,  bool awaitingConfirmationReminderSent,  String? reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.teamId,_that.creditorId,_that.debtorId,_that.debtIds,_that.payoutShown,_that.reportedAt,_that.awaitingConfirmationReminderSent,_that.reference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String teamId,  String creditorId,  String debtorId,  List<String> debtIds,  PayoutSnapshot payoutShown,  DateTime reportedAt,  bool awaitingConfirmationReminderSent,  String? reference)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.teamId,_that.creditorId,_that.debtorId,_that.debtIds,_that.payoutShown,_that.reportedAt,_that.awaitingConfirmationReminderSent,_that.reference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String teamId,  String creditorId,  String debtorId,  List<String> debtIds,  PayoutSnapshot payoutShown,  DateTime reportedAt,  bool awaitingConfirmationReminderSent,  String? reference)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.teamId,_that.creditorId,_that.debtorId,_that.debtIds,_that.payoutShown,_that.reportedAt,_that.awaitingConfirmationReminderSent,_that.reference);case _:
  return null;

}
}

}

/// @nodoc


class _Payment implements Payment {
  const _Payment({required this.id, required this.teamId, required this.creditorId, required this.debtorId, required  List<String> debtIds, required this.payoutShown, required this.reportedAt, this.awaitingConfirmationReminderSent = false, this.reference}): _debtIds = debtIds;
  

@override final  String id;
@override final  String teamId;
@override final  String creditorId;
@override final  String debtorId;
 final  List<String> _debtIds;
@override List<String> get debtIds {
  if (_debtIds is EqualUnmodifiableListView) return _debtIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_debtIds);
}

@override final  PayoutSnapshot payoutShown;
@override final  DateTime reportedAt;
@override@JsonKey() final  bool awaitingConfirmationReminderSent;
@override final  String? reference;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.creditorId, creditorId) || other.creditorId == creditorId)&&(identical(other.debtorId, debtorId) || other.debtorId == debtorId)&&const DeepCollectionEquality().equals(other.debtIds, _debtIds)&&(identical(other.payoutShown, payoutShown) || other.payoutShown == payoutShown)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.awaitingConfirmationReminderSent, awaitingConfirmationReminderSent) || other.awaitingConfirmationReminderSent == awaitingConfirmationReminderSent)&&(identical(other.reference, reference) || other.reference == reference));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,teamId,creditorId,debtorId,const DeepCollectionEquality().hash(_debtIds),payoutShown,reportedAt,awaitingConfirmationReminderSent,reference);
}

@override
String toString() {
    return 'Payment(id: $id, teamId: $teamId, creditorId: $creditorId, debtorId: $debtorId, debtIds: $debtIds, payoutShown: $payoutShown, reportedAt: $reportedAt, awaitingConfirmationReminderSent: $awaitingConfirmationReminderSent, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String teamId, String creditorId, String debtorId, List<String> debtIds, PayoutSnapshot payoutShown, DateTime reportedAt, bool awaitingConfirmationReminderSent, String? reference
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? teamId = null,Object? creditorId = null,Object? debtorId = null,Object? debtIds = null,Object? payoutShown = null,Object? reportedAt = null,Object? awaitingConfirmationReminderSent = null,Object? reference = freezed,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,creditorId: null == creditorId ? _self.creditorId : creditorId // ignore: cast_nullable_to_non_nullable
as String,debtorId: null == debtorId ? _self.debtorId : debtorId // ignore: cast_nullable_to_non_nullable
as String,debtIds: null == debtIds ? _self._debtIds : debtIds // ignore: cast_nullable_to_non_nullable
as List<String>,payoutShown: null == payoutShown ? _self.payoutShown : payoutShown // ignore: cast_nullable_to_non_nullable
as PayoutSnapshot,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,awaitingConfirmationReminderSent: null == awaitingConfirmationReminderSent ? _self.awaitingConfirmationReminderSent : awaitingConfirmationReminderSent // ignore: cast_nullable_to_non_nullable
as bool,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
