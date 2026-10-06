// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Order {

 String get id; String get teamId; String get creditorId; String get concept; Money get total; DateTime get spentAt; DateTime get createdAt; DateTime get updatedAt; String? get note;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Order;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.teamId, _this.teamId) || other.teamId == _this.teamId)&&(identical(other.creditorId, _this.creditorId) || other.creditorId == _this.creditorId)&&(identical(other.concept, _this.concept) || other.concept == _this.concept)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.spentAt, _this.spentAt) || other.spentAt == _this.spentAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.note, _this.note) || other.note == _this.note));
}


@override
int get hashCode {
  final _this = this as Order;
  return Object.hash(runtimeType,_this.id,_this.teamId,_this.creditorId,_this.concept,_this.total,_this.spentAt,_this.createdAt,_this.updatedAt,_this.note);
}

@override
String toString() {
  final _this = this as Order;
  return 'Order(id: ${_this.id}, teamId: ${_this.teamId}, creditorId: ${_this.creditorId}, concept: ${_this.concept}, total: ${_this.total}, spentAt: ${_this.spentAt}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 String id, String teamId, String creditorId, String concept, Money total, DateTime spentAt, DateTime createdAt, DateTime updatedAt, String? note
});




}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? teamId = null,Object? creditorId = null,Object? concept = null,Object? total = null,Object? spentAt = null,Object? createdAt = null,Object? updatedAt = null,Object? note = freezed,}) {
  return _then(Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,creditorId: null == creditorId ? _self.creditorId : creditorId // ignore: cast_nullable_to_non_nullable
as String,concept: null == concept ? _self.concept : concept // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,spentAt: null == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String teamId,  String creditorId,  String concept,  Money total,  DateTime spentAt,  DateTime createdAt,  DateTime updatedAt,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.teamId,_that.creditorId,_that.concept,_that.total,_that.spentAt,_that.createdAt,_that.updatedAt,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String teamId,  String creditorId,  String concept,  Money total,  DateTime spentAt,  DateTime createdAt,  DateTime updatedAt,  String? note)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.id,_that.teamId,_that.creditorId,_that.concept,_that.total,_that.spentAt,_that.createdAt,_that.updatedAt,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String teamId,  String creditorId,  String concept,  Money total,  DateTime spentAt,  DateTime createdAt,  DateTime updatedAt,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.teamId,_that.creditorId,_that.concept,_that.total,_that.spentAt,_that.createdAt,_that.updatedAt,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _Order implements Order {
  const _Order({required this.id, required this.teamId, required this.creditorId, required this.concept, required this.total, required this.spentAt, required this.createdAt, required this.updatedAt, this.note});
  

@override final  String id;
@override final  String teamId;
@override final  String creditorId;
@override final  String concept;
@override final  Money total;
@override final  DateTime spentAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? note;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.creditorId, creditorId) || other.creditorId == creditorId)&&(identical(other.concept, concept) || other.concept == concept)&&(identical(other.total, total) || other.total == total)&&(identical(other.spentAt, spentAt) || other.spentAt == spentAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,teamId,creditorId,concept,total,spentAt,createdAt,updatedAt,note);
}

@override
String toString() {
    return 'Order(id: $id, teamId: $teamId, creditorId: $creditorId, concept: $concept, total: $total, spentAt: $spentAt, createdAt: $createdAt, updatedAt: $updatedAt, note: $note)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String teamId, String creditorId, String concept, Money total, DateTime spentAt, DateTime createdAt, DateTime updatedAt, String? note
});




}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? teamId = null,Object? creditorId = null,Object? concept = null,Object? total = null,Object? spentAt = null,Object? createdAt = null,Object? updatedAt = null,Object? note = freezed,}) {
  return _then(_Order(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,creditorId: null == creditorId ? _self.creditorId : creditorId // ignore: cast_nullable_to_non_nullable
as String,concept: null == concept ? _self.concept : concept // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money,spentAt: null == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
