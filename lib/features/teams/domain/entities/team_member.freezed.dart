// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamMember {

 String get teamId; String get userId; TeamRole get role; DateTime get joinedAt; String get displayName; String? get photoUrl; PayoutMethod? get payoutMethod;
/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamMemberCopyWith<TeamMember> get copyWith => _$TeamMemberCopyWithImpl<TeamMember>(this as TeamMember, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TeamMember;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamMember&&(identical(other.teamId, _this.teamId) || other.teamId == _this.teamId)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.joinedAt, _this.joinedAt) || other.joinedAt == _this.joinedAt)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.payoutMethod, _this.payoutMethod) || other.payoutMethod == _this.payoutMethod));
}


@override
int get hashCode {
  final _this = this as TeamMember;
  return Object.hash(runtimeType,_this.teamId,_this.userId,_this.role,_this.joinedAt,_this.displayName,_this.photoUrl,_this.payoutMethod);
}

@override
String toString() {
  final _this = this as TeamMember;
  return 'TeamMember(teamId: ${_this.teamId}, userId: ${_this.userId}, role: ${_this.role}, joinedAt: ${_this.joinedAt}, displayName: ${_this.displayName}, photoUrl: ${_this.photoUrl}, payoutMethod: ${_this.payoutMethod})';
}


}

/// @nodoc
abstract mixin class $TeamMemberCopyWith<$Res>  {
  factory $TeamMemberCopyWith(TeamMember value, $Res Function(TeamMember) _then) = _$TeamMemberCopyWithImpl;
@useResult
$Res call({
 String teamId, String userId, TeamRole role, DateTime joinedAt, String displayName, String? photoUrl, PayoutMethod? payoutMethod
});




}
/// @nodoc
class _$TeamMemberCopyWithImpl<$Res>
    implements $TeamMemberCopyWith<$Res> {
  _$TeamMemberCopyWithImpl(this._self, this._then);

  final TeamMember _self;
  final $Res Function(TeamMember) _then;

/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamId = null,Object? userId = null,Object? role = null,Object? joinedAt = null,Object? displayName = null,Object? photoUrl = freezed,Object? payoutMethod = freezed,}) {
  return _then(TeamMember(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TeamRole,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,payoutMethod: freezed == payoutMethod ? _self.payoutMethod : payoutMethod // ignore: cast_nullable_to_non_nullable
as PayoutMethod?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamMember].
extension TeamMemberPatterns on TeamMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamMember value)  $default,){
final _that = this;
switch (_that) {
case _TeamMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamMember value)?  $default,){
final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String teamId,  String userId,  TeamRole role,  DateTime joinedAt,  String displayName,  String? photoUrl,  PayoutMethod? payoutMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
return $default(_that.teamId,_that.userId,_that.role,_that.joinedAt,_that.displayName,_that.photoUrl,_that.payoutMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String teamId,  String userId,  TeamRole role,  DateTime joinedAt,  String displayName,  String? photoUrl,  PayoutMethod? payoutMethod)  $default,) {final _that = this;
switch (_that) {
case _TeamMember():
return $default(_that.teamId,_that.userId,_that.role,_that.joinedAt,_that.displayName,_that.photoUrl,_that.payoutMethod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String teamId,  String userId,  TeamRole role,  DateTime joinedAt,  String displayName,  String? photoUrl,  PayoutMethod? payoutMethod)?  $default,) {final _that = this;
switch (_that) {
case _TeamMember() when $default != null:
return $default(_that.teamId,_that.userId,_that.role,_that.joinedAt,_that.displayName,_that.photoUrl,_that.payoutMethod);case _:
  return null;

}
}

}

/// @nodoc


class _TeamMember implements TeamMember {
  const _TeamMember({required this.teamId, required this.userId, required this.role, required this.joinedAt, required this.displayName, this.photoUrl, this.payoutMethod});
  

@override final  String teamId;
@override final  String userId;
@override final  TeamRole role;
@override final  DateTime joinedAt;
@override final  String displayName;
@override final  String? photoUrl;
@override final  PayoutMethod? payoutMethod;

/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamMemberCopyWith<_TeamMember> get copyWith => __$TeamMemberCopyWithImpl<_TeamMember>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamMember&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.payoutMethod, payoutMethod) || other.payoutMethod == payoutMethod));
}


@override
int get hashCode {
    return Object.hash(runtimeType,teamId,userId,role,joinedAt,displayName,photoUrl,payoutMethod);
}

@override
String toString() {
    return 'TeamMember(teamId: $teamId, userId: $userId, role: $role, joinedAt: $joinedAt, displayName: $displayName, photoUrl: $photoUrl, payoutMethod: $payoutMethod)';
}


}

/// @nodoc
abstract mixin class _$TeamMemberCopyWith<$Res> implements $TeamMemberCopyWith<$Res> {
  factory _$TeamMemberCopyWith(_TeamMember value, $Res Function(_TeamMember) _then) = __$TeamMemberCopyWithImpl;
@override @useResult
$Res call({
 String teamId, String userId, TeamRole role, DateTime joinedAt, String displayName, String? photoUrl, PayoutMethod? payoutMethod
});




}
/// @nodoc
class __$TeamMemberCopyWithImpl<$Res>
    implements _$TeamMemberCopyWith<$Res> {
  __$TeamMemberCopyWithImpl(this._self, this._then);

  final _TeamMember _self;
  final $Res Function(_TeamMember) _then;

/// Create a copy of TeamMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamId = null,Object? userId = null,Object? role = null,Object? joinedAt = null,Object? displayName = null,Object? photoUrl = freezed,Object? payoutMethod = freezed,}) {
  return _then(_TeamMember(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TeamRole,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,payoutMethod: freezed == payoutMethod ? _self.payoutMethod : payoutMethod // ignore: cast_nullable_to_non_nullable
as PayoutMethod?,
  ));
}


}

// dart format on
