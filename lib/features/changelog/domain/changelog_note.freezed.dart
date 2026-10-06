// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changelog_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangelogNote {

 ChangelogNoteType get type; String get subject; String? get scope;
/// Create a copy of ChangelogNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangelogNoteCopyWith<ChangelogNote> get copyWith => _$ChangelogNoteCopyWithImpl<ChangelogNote>(this as ChangelogNote, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChangelogNote;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangelogNote&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.scope, _this.scope) || other.scope == _this.scope));
}


@override
int get hashCode {
  final _this = this as ChangelogNote;
  return Object.hash(runtimeType,_this.type,_this.subject,_this.scope);
}

@override
String toString() {
  final _this = this as ChangelogNote;
  return 'ChangelogNote(type: ${_this.type}, subject: ${_this.subject}, scope: ${_this.scope})';
}


}

/// @nodoc
abstract mixin class $ChangelogNoteCopyWith<$Res>  {
  factory $ChangelogNoteCopyWith(ChangelogNote value, $Res Function(ChangelogNote) _then) = _$ChangelogNoteCopyWithImpl;
@useResult
$Res call({
 ChangelogNoteType type, String subject, String? scope
});




}
/// @nodoc
class _$ChangelogNoteCopyWithImpl<$Res>
    implements $ChangelogNoteCopyWith<$Res> {
  _$ChangelogNoteCopyWithImpl(this._self, this._then);

  final ChangelogNote _self;
  final $Res Function(ChangelogNote) _then;

/// Create a copy of ChangelogNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? subject = null,Object? scope = freezed,}) {
  return _then(ChangelogNote(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChangelogNoteType,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,scope: freezed == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangelogNote].
extension ChangelogNotePatterns on ChangelogNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangelogNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangelogNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangelogNote value)  $default,){
final _that = this;
switch (_that) {
case _ChangelogNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangelogNote value)?  $default,){
final _that = this;
switch (_that) {
case _ChangelogNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChangelogNoteType type,  String subject,  String? scope)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangelogNote() when $default != null:
return $default(_that.type,_that.subject,_that.scope);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChangelogNoteType type,  String subject,  String? scope)  $default,) {final _that = this;
switch (_that) {
case _ChangelogNote():
return $default(_that.type,_that.subject,_that.scope);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChangelogNoteType type,  String subject,  String? scope)?  $default,) {final _that = this;
switch (_that) {
case _ChangelogNote() when $default != null:
return $default(_that.type,_that.subject,_that.scope);case _:
  return null;

}
}

}

/// @nodoc


class _ChangelogNote implements ChangelogNote {
  const _ChangelogNote({required this.type, required this.subject, this.scope});
  

@override final  ChangelogNoteType type;
@override final  String subject;
@override final  String? scope;

/// Create a copy of ChangelogNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangelogNoteCopyWith<_ChangelogNote> get copyWith => __$ChangelogNoteCopyWithImpl<_ChangelogNote>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangelogNote&&(identical(other.type, type) || other.type == type)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.scope, scope) || other.scope == scope));
}


@override
int get hashCode {
    return Object.hash(runtimeType,type,subject,scope);
}

@override
String toString() {
    return 'ChangelogNote(type: $type, subject: $subject, scope: $scope)';
}


}

/// @nodoc
abstract mixin class _$ChangelogNoteCopyWith<$Res> implements $ChangelogNoteCopyWith<$Res> {
  factory _$ChangelogNoteCopyWith(_ChangelogNote value, $Res Function(_ChangelogNote) _then) = __$ChangelogNoteCopyWithImpl;
@override @useResult
$Res call({
 ChangelogNoteType type, String subject, String? scope
});




}
/// @nodoc
class __$ChangelogNoteCopyWithImpl<$Res>
    implements _$ChangelogNoteCopyWith<$Res> {
  __$ChangelogNoteCopyWithImpl(this._self, this._then);

  final _ChangelogNote _self;
  final $Res Function(_ChangelogNote) _then;

/// Create a copy of ChangelogNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? subject = null,Object? scope = freezed,}) {
  return _then(_ChangelogNote(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChangelogNoteType,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,scope: freezed == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
