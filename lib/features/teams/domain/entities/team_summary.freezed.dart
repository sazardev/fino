// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeamSummary {

 Team get team; TeamRole get role; int get memberCount;
/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamSummaryCopyWith<TeamSummary> get copyWith => _$TeamSummaryCopyWithImpl<TeamSummary>(this as TeamSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TeamSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamSummary&&(identical(other.team, _this.team) || other.team == _this.team)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.memberCount, _this.memberCount) || other.memberCount == _this.memberCount));
}


@override
int get hashCode {
  final _this = this as TeamSummary;
  return Object.hash(runtimeType,_this.team,_this.role,_this.memberCount);
}

@override
String toString() {
  final _this = this as TeamSummary;
  return 'TeamSummary(team: ${_this.team}, role: ${_this.role}, memberCount: ${_this.memberCount})';
}


}

/// @nodoc
abstract mixin class $TeamSummaryCopyWith<$Res>  {
  factory $TeamSummaryCopyWith(TeamSummary value, $Res Function(TeamSummary) _then) = _$TeamSummaryCopyWithImpl;
@useResult
$Res call({
 Team team, TeamRole role, int memberCount
});


$TeamCopyWith<$Res> get team;

}
/// @nodoc
class _$TeamSummaryCopyWithImpl<$Res>
    implements $TeamSummaryCopyWith<$Res> {
  _$TeamSummaryCopyWithImpl(this._self, this._then);

  final TeamSummary _self;
  final $Res Function(TeamSummary) _then;

/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? team = null,Object? role = null,Object? memberCount = null,}) {
  return _then(TeamSummary(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TeamRole,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// Adds pattern-matching-related methods to [TeamSummary].
extension TeamSummaryPatterns on TeamSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamSummary value)  $default,){
final _that = this;
switch (_that) {
case _TeamSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TeamSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Team team,  TeamRole role,  int memberCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamSummary() when $default != null:
return $default(_that.team,_that.role,_that.memberCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Team team,  TeamRole role,  int memberCount)  $default,) {final _that = this;
switch (_that) {
case _TeamSummary():
return $default(_that.team,_that.role,_that.memberCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Team team,  TeamRole role,  int memberCount)?  $default,) {final _that = this;
switch (_that) {
case _TeamSummary() when $default != null:
return $default(_that.team,_that.role,_that.memberCount);case _:
  return null;

}
}

}

/// @nodoc


class _TeamSummary implements TeamSummary {
  const _TeamSummary({required this.team, required this.role, required this.memberCount});
  

@override final  Team team;
@override final  TeamRole role;
@override final  int memberCount;

/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamSummaryCopyWith<_TeamSummary> get copyWith => __$TeamSummaryCopyWithImpl<_TeamSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamSummary&&(identical(other.team, team) || other.team == team)&&(identical(other.role, role) || other.role == role)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,team,role,memberCount);
}

@override
String toString() {
    return 'TeamSummary(team: $team, role: $role, memberCount: $memberCount)';
}


}

/// @nodoc
abstract mixin class _$TeamSummaryCopyWith<$Res> implements $TeamSummaryCopyWith<$Res> {
  factory _$TeamSummaryCopyWith(_TeamSummary value, $Res Function(_TeamSummary) _then) = __$TeamSummaryCopyWithImpl;
@override @useResult
$Res call({
 Team team, TeamRole role, int memberCount
});


@override $TeamCopyWith<$Res> get team;

}
/// @nodoc
class __$TeamSummaryCopyWithImpl<$Res>
    implements _$TeamSummaryCopyWith<$Res> {
  __$TeamSummaryCopyWithImpl(this._self, this._then);

  final _TeamSummary _self;
  final $Res Function(_TeamSummary) _then;

/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? team = null,Object? role = null,Object? memberCount = null,}) {
  return _then(_TeamSummary(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TeamRole,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TeamSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}

// dart format on
