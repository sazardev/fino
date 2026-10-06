// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderDraft {

 DateTime get spentAt; String? get teamId; String get concept; Money? get total; String get note;/// "Yo también consumí": el acreedor cuenta como una parte más.
 bool get creditorIncluded;/// Deudores elegidos, en el orden en que se agregaron.
 List<String> get participants;/// Montos fijados a mano; los demás se reparten solos.
 Map<String, Money> get fixed;
/// Create a copy of OrderDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDraftCopyWith<OrderDraft> get copyWith => _$OrderDraftCopyWithImpl<OrderDraft>(this as OrderDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OrderDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDraft&&(identical(other.spentAt, _this.spentAt) || other.spentAt == _this.spentAt)&&(identical(other.teamId, _this.teamId) || other.teamId == _this.teamId)&&(identical(other.concept, _this.concept) || other.concept == _this.concept)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.creditorIncluded, _this.creditorIncluded) || other.creditorIncluded == _this.creditorIncluded)&&const DeepCollectionEquality().equals(other.participants, _this.participants)&&const DeepCollectionEquality().equals(other.fixed, _this.fixed));
}


@override
int get hashCode {
  final _this = this as OrderDraft;
  return Object.hash(runtimeType,_this.spentAt,_this.teamId,_this.concept,_this.total,_this.note,_this.creditorIncluded,const DeepCollectionEquality().hash(_this.participants),const DeepCollectionEquality().hash(_this.fixed));
}

@override
String toString() {
  final _this = this as OrderDraft;
  return 'OrderDraft(spentAt: ${_this.spentAt}, teamId: ${_this.teamId}, concept: ${_this.concept}, total: ${_this.total}, note: ${_this.note}, creditorIncluded: ${_this.creditorIncluded}, participants: ${_this.participants}, fixed: ${_this.fixed})';
}


}

/// @nodoc
abstract mixin class $OrderDraftCopyWith<$Res>  {
  factory $OrderDraftCopyWith(OrderDraft value, $Res Function(OrderDraft) _then) = _$OrderDraftCopyWithImpl;
@useResult
$Res call({
 DateTime spentAt, String? teamId, String concept, Money? total, String note, bool creditorIncluded, List<String> participants, Map<String, Money> fixed
});




}
/// @nodoc
class _$OrderDraftCopyWithImpl<$Res>
    implements $OrderDraftCopyWith<$Res> {
  _$OrderDraftCopyWithImpl(this._self, this._then);

  final OrderDraft _self;
  final $Res Function(OrderDraft) _then;

/// Create a copy of OrderDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? spentAt = null,Object? teamId = freezed,Object? concept = null,Object? total = freezed,Object? note = null,Object? creditorIncluded = null,Object? participants = null,Object? fixed = null,}) {
  return _then(OrderDraft(
spentAt: null == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,concept: null == concept ? _self.concept : concept // ignore: cast_nullable_to_non_nullable
as String,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,creditorIncluded: null == creditorIncluded ? _self.creditorIncluded : creditorIncluded // ignore: cast_nullable_to_non_nullable
as bool,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,fixed: null == fixed ? _self.fixed : fixed // ignore: cast_nullable_to_non_nullable
as Map<String, Money>,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderDraft].
extension OrderDraftPatterns on OrderDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderDraft value)  $default,){
final _that = this;
switch (_that) {
case _OrderDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderDraft value)?  $default,){
final _that = this;
switch (_that) {
case _OrderDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime spentAt,  String? teamId,  String concept,  Money? total,  String note,  bool creditorIncluded,  List<String> participants,  Map<String, Money> fixed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderDraft() when $default != null:
return $default(_that.spentAt,_that.teamId,_that.concept,_that.total,_that.note,_that.creditorIncluded,_that.participants,_that.fixed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime spentAt,  String? teamId,  String concept,  Money? total,  String note,  bool creditorIncluded,  List<String> participants,  Map<String, Money> fixed)  $default,) {final _that = this;
switch (_that) {
case _OrderDraft():
return $default(_that.spentAt,_that.teamId,_that.concept,_that.total,_that.note,_that.creditorIncluded,_that.participants,_that.fixed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime spentAt,  String? teamId,  String concept,  Money? total,  String note,  bool creditorIncluded,  List<String> participants,  Map<String, Money> fixed)?  $default,) {final _that = this;
switch (_that) {
case _OrderDraft() when $default != null:
return $default(_that.spentAt,_that.teamId,_that.concept,_that.total,_that.note,_that.creditorIncluded,_that.participants,_that.fixed);case _:
  return null;

}
}

}

/// @nodoc


class _OrderDraft implements OrderDraft {
  const _OrderDraft({required this.spentAt, this.teamId, this.concept = '', this.total, this.note = '', this.creditorIncluded = true,  List<String> participants = const [],  Map<String, Money> fixed = const {}}): _participants = participants,_fixed = fixed;
  

@override final  DateTime spentAt;
@override final  String? teamId;
@override@JsonKey() final  String concept;
@override final  Money? total;
@override@JsonKey() final  String note;
/// "Yo también consumí": el acreedor cuenta como una parte más.
@override@JsonKey() final  bool creditorIncluded;
/// Deudores elegidos, en el orden en que se agregaron.
 final  List<String> _participants;
/// Deudores elegidos, en el orden en que se agregaron.
@override@JsonKey() List<String> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

/// Montos fijados a mano; los demás se reparten solos.
 final  Map<String, Money> _fixed;
/// Montos fijados a mano; los demás se reparten solos.
@override@JsonKey() Map<String, Money> get fixed {
  if (_fixed is EqualUnmodifiableMapView) return _fixed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fixed);
}


/// Create a copy of OrderDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDraftCopyWith<_OrderDraft> get copyWith => __$OrderDraftCopyWithImpl<_OrderDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDraft&&(identical(other.spentAt, spentAt) || other.spentAt == spentAt)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.concept, concept) || other.concept == concept)&&(identical(other.total, total) || other.total == total)&&(identical(other.note, note) || other.note == note)&&(identical(other.creditorIncluded, creditorIncluded) || other.creditorIncluded == creditorIncluded)&&const DeepCollectionEquality().equals(other.participants, _participants)&&const DeepCollectionEquality().equals(other.fixed, _fixed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,spentAt,teamId,concept,total,note,creditorIncluded,const DeepCollectionEquality().hash(_participants),const DeepCollectionEquality().hash(_fixed));
}

@override
String toString() {
    return 'OrderDraft(spentAt: $spentAt, teamId: $teamId, concept: $concept, total: $total, note: $note, creditorIncluded: $creditorIncluded, participants: $participants, fixed: $fixed)';
}


}

/// @nodoc
abstract mixin class _$OrderDraftCopyWith<$Res> implements $OrderDraftCopyWith<$Res> {
  factory _$OrderDraftCopyWith(_OrderDraft value, $Res Function(_OrderDraft) _then) = __$OrderDraftCopyWithImpl;
@override @useResult
$Res call({
 DateTime spentAt, String? teamId, String concept, Money? total, String note, bool creditorIncluded, List<String> participants, Map<String, Money> fixed
});




}
/// @nodoc
class __$OrderDraftCopyWithImpl<$Res>
    implements _$OrderDraftCopyWith<$Res> {
  __$OrderDraftCopyWithImpl(this._self, this._then);

  final _OrderDraft _self;
  final $Res Function(_OrderDraft) _then;

/// Create a copy of OrderDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? spentAt = null,Object? teamId = freezed,Object? concept = null,Object? total = freezed,Object? note = null,Object? creditorIncluded = null,Object? participants = null,Object? fixed = null,}) {
  return _then(_OrderDraft(
spentAt: null == spentAt ? _self.spentAt : spentAt // ignore: cast_nullable_to_non_nullable
as DateTime,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,concept: null == concept ? _self.concept : concept // ignore: cast_nullable_to_non_nullable
as String,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Money?,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,creditorIncluded: null == creditorIncluded ? _self.creditorIncluded : creditorIncluded // ignore: cast_nullable_to_non_nullable
as bool,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,fixed: null == fixed ? _self._fixed : fixed // ignore: cast_nullable_to_non_nullable
as Map<String, Money>,
  ));
}


}

// dart format on
