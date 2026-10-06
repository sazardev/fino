// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderFilter {

 String get query; OrderListStatus get status; String? get teamId; bool get onlyMine;
/// Create a copy of OrderFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderFilterCopyWith<OrderFilter> get copyWith => _$OrderFilterCopyWithImpl<OrderFilter>(this as OrderFilter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OrderFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderFilter&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.teamId, _this.teamId) || other.teamId == _this.teamId)&&(identical(other.onlyMine, _this.onlyMine) || other.onlyMine == _this.onlyMine));
}


@override
int get hashCode {
  final _this = this as OrderFilter;
  return Object.hash(runtimeType,_this.query,_this.status,_this.teamId,_this.onlyMine);
}

@override
String toString() {
  final _this = this as OrderFilter;
  return 'OrderFilter(query: ${_this.query}, status: ${_this.status}, teamId: ${_this.teamId}, onlyMine: ${_this.onlyMine})';
}


}

/// @nodoc
abstract mixin class $OrderFilterCopyWith<$Res>  {
  factory $OrderFilterCopyWith(OrderFilter value, $Res Function(OrderFilter) _then) = _$OrderFilterCopyWithImpl;
@useResult
$Res call({
 String query, OrderListStatus status, String? teamId, bool onlyMine
});




}
/// @nodoc
class _$OrderFilterCopyWithImpl<$Res>
    implements $OrderFilterCopyWith<$Res> {
  _$OrderFilterCopyWithImpl(this._self, this._then);

  final OrderFilter _self;
  final $Res Function(OrderFilter) _then;

/// Create a copy of OrderFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? status = null,Object? teamId = freezed,Object? onlyMine = null,}) {
  return _then(OrderFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderListStatus,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,onlyMine: null == onlyMine ? _self.onlyMine : onlyMine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderFilter].
extension OrderFilterPatterns on OrderFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderFilter value)  $default,){
final _that = this;
switch (_that) {
case _OrderFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderFilter value)?  $default,){
final _that = this;
switch (_that) {
case _OrderFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  OrderListStatus status,  String? teamId,  bool onlyMine)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderFilter() when $default != null:
return $default(_that.query,_that.status,_that.teamId,_that.onlyMine);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  OrderListStatus status,  String? teamId,  bool onlyMine)  $default,) {final _that = this;
switch (_that) {
case _OrderFilter():
return $default(_that.query,_that.status,_that.teamId,_that.onlyMine);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  OrderListStatus status,  String? teamId,  bool onlyMine)?  $default,) {final _that = this;
switch (_that) {
case _OrderFilter() when $default != null:
return $default(_that.query,_that.status,_that.teamId,_that.onlyMine);case _:
  return null;

}
}

}

/// @nodoc


class _OrderFilter implements OrderFilter {
  const _OrderFilter({this.query = '', this.status = OrderListStatus.all, this.teamId, this.onlyMine = false});
  

@override@JsonKey() final  String query;
@override@JsonKey() final  OrderListStatus status;
@override final  String? teamId;
@override@JsonKey() final  bool onlyMine;

/// Create a copy of OrderFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderFilterCopyWith<_OrderFilter> get copyWith => __$OrderFilterCopyWithImpl<_OrderFilter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderFilter&&(identical(other.query, query) || other.query == query)&&(identical(other.status, status) || other.status == status)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.onlyMine, onlyMine) || other.onlyMine == onlyMine));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,status,teamId,onlyMine);
}

@override
String toString() {
    return 'OrderFilter(query: $query, status: $status, teamId: $teamId, onlyMine: $onlyMine)';
}


}

/// @nodoc
abstract mixin class _$OrderFilterCopyWith<$Res> implements $OrderFilterCopyWith<$Res> {
  factory _$OrderFilterCopyWith(_OrderFilter value, $Res Function(_OrderFilter) _then) = __$OrderFilterCopyWithImpl;
@override @useResult
$Res call({
 String query, OrderListStatus status, String? teamId, bool onlyMine
});




}
/// @nodoc
class __$OrderFilterCopyWithImpl<$Res>
    implements _$OrderFilterCopyWith<$Res> {
  __$OrderFilterCopyWithImpl(this._self, this._then);

  final _OrderFilter _self;
  final $Res Function(_OrderFilter) _then;

/// Create a copy of OrderFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? status = null,Object? teamId = freezed,Object? onlyMine = null,}) {
  return _then(_OrderFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderListStatus,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,onlyMine: null == onlyMine ? _self.onlyMine : onlyMine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
