// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changelog_release.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangelogRelease {

 String get version; DateTime get date; List<ChangelogNote> get notes;
/// Create a copy of ChangelogRelease
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangelogReleaseCopyWith<ChangelogRelease> get copyWith => _$ChangelogReleaseCopyWithImpl<ChangelogRelease>(this as ChangelogRelease, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChangelogRelease;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangelogRelease&&(identical(other.version, _this.version) || other.version == _this.version)&&(identical(other.date, _this.date) || other.date == _this.date)&&const DeepCollectionEquality().equals(other.notes, _this.notes));
}


@override
int get hashCode {
  final _this = this as ChangelogRelease;
  return Object.hash(runtimeType,_this.version,_this.date,const DeepCollectionEquality().hash(_this.notes));
}

@override
String toString() {
  final _this = this as ChangelogRelease;
  return 'ChangelogRelease(version: ${_this.version}, date: ${_this.date}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $ChangelogReleaseCopyWith<$Res>  {
  factory $ChangelogReleaseCopyWith(ChangelogRelease value, $Res Function(ChangelogRelease) _then) = _$ChangelogReleaseCopyWithImpl;
@useResult
$Res call({
 String version, DateTime date, List<ChangelogNote> notes
});




}
/// @nodoc
class _$ChangelogReleaseCopyWithImpl<$Res>
    implements $ChangelogReleaseCopyWith<$Res> {
  _$ChangelogReleaseCopyWithImpl(this._self, this._then);

  final ChangelogRelease _self;
  final $Res Function(ChangelogRelease) _then;

/// Create a copy of ChangelogRelease
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? date = null,Object? notes = null,}) {
  return _then(ChangelogRelease(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<ChangelogNote>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangelogRelease].
extension ChangelogReleasePatterns on ChangelogRelease {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangelogRelease value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangelogRelease() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangelogRelease value)  $default,){
final _that = this;
switch (_that) {
case _ChangelogRelease():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangelogRelease value)?  $default,){
final _that = this;
switch (_that) {
case _ChangelogRelease() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  DateTime date,  List<ChangelogNote> notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangelogRelease() when $default != null:
return $default(_that.version,_that.date,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  DateTime date,  List<ChangelogNote> notes)  $default,) {final _that = this;
switch (_that) {
case _ChangelogRelease():
return $default(_that.version,_that.date,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  DateTime date,  List<ChangelogNote> notes)?  $default,) {final _that = this;
switch (_that) {
case _ChangelogRelease() when $default != null:
return $default(_that.version,_that.date,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _ChangelogRelease implements ChangelogRelease {
  const _ChangelogRelease({required this.version, required this.date, required  List<ChangelogNote> notes}): _notes = notes;
  

@override final  String version;
@override final  DateTime date;
 final  List<ChangelogNote> _notes;
@override List<ChangelogNote> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}


/// Create a copy of ChangelogRelease
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangelogReleaseCopyWith<_ChangelogRelease> get copyWith => __$ChangelogReleaseCopyWithImpl<_ChangelogRelease>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangelogRelease&&(identical(other.version, version) || other.version == version)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.notes, _notes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,version,date,const DeepCollectionEquality().hash(_notes));
}

@override
String toString() {
    return 'ChangelogRelease(version: $version, date: $date, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ChangelogReleaseCopyWith<$Res> implements $ChangelogReleaseCopyWith<$Res> {
  factory _$ChangelogReleaseCopyWith(_ChangelogRelease value, $Res Function(_ChangelogRelease) _then) = __$ChangelogReleaseCopyWithImpl;
@override @useResult
$Res call({
 String version, DateTime date, List<ChangelogNote> notes
});




}
/// @nodoc
class __$ChangelogReleaseCopyWithImpl<$Res>
    implements _$ChangelogReleaseCopyWith<$Res> {
  __$ChangelogReleaseCopyWithImpl(this._self, this._then);

  final _ChangelogRelease _self;
  final $Res Function(_ChangelogRelease) _then;

/// Create a copy of ChangelogRelease
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? date = null,Object? notes = null,}) {
  return _then(_ChangelogRelease(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<ChangelogNote>,
  ));
}


}

// dart format on
