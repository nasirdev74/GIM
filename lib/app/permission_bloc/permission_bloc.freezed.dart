// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PermissionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkLocationPermission,
    required TResult Function() requestLocationPermission,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkLocationPermission,
    TResult? Function()? requestLocationPermission,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkLocationPermission,
    TResult Function()? requestLocationPermission,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckLocationPermission value)
        checkLocationPermission,
    required TResult Function(_RequestLocationPermission value)
        requestLocationPermission,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckLocationPermission value)? checkLocationPermission,
    TResult? Function(_RequestLocationPermission value)?
        requestLocationPermission,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckLocationPermission value)? checkLocationPermission,
    TResult Function(_RequestLocationPermission value)?
        requestLocationPermission,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionEventCopyWith<$Res> {
  factory $PermissionEventCopyWith(
          PermissionEvent value, $Res Function(PermissionEvent) then) =
      _$PermissionEventCopyWithImpl<$Res, PermissionEvent>;
}

/// @nodoc
class _$PermissionEventCopyWithImpl<$Res, $Val extends PermissionEvent>
    implements $PermissionEventCopyWith<$Res> {
  _$PermissionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CheckLocationPermissionImplCopyWith<$Res> {
  factory _$$CheckLocationPermissionImplCopyWith(
          _$CheckLocationPermissionImpl value,
          $Res Function(_$CheckLocationPermissionImpl) then) =
      __$$CheckLocationPermissionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckLocationPermissionImplCopyWithImpl<$Res>
    extends _$PermissionEventCopyWithImpl<$Res, _$CheckLocationPermissionImpl>
    implements _$$CheckLocationPermissionImplCopyWith<$Res> {
  __$$CheckLocationPermissionImplCopyWithImpl(
      _$CheckLocationPermissionImpl _value,
      $Res Function(_$CheckLocationPermissionImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CheckLocationPermissionImpl implements _CheckLocationPermission {
  const _$CheckLocationPermissionImpl();

  @override
  String toString() {
    return 'PermissionEvent.checkLocationPermission()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckLocationPermissionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkLocationPermission,
    required TResult Function() requestLocationPermission,
  }) {
    return checkLocationPermission();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkLocationPermission,
    TResult? Function()? requestLocationPermission,
  }) {
    return checkLocationPermission?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkLocationPermission,
    TResult Function()? requestLocationPermission,
    required TResult orElse(),
  }) {
    if (checkLocationPermission != null) {
      return checkLocationPermission();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckLocationPermission value)
        checkLocationPermission,
    required TResult Function(_RequestLocationPermission value)
        requestLocationPermission,
  }) {
    return checkLocationPermission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckLocationPermission value)? checkLocationPermission,
    TResult? Function(_RequestLocationPermission value)?
        requestLocationPermission,
  }) {
    return checkLocationPermission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckLocationPermission value)? checkLocationPermission,
    TResult Function(_RequestLocationPermission value)?
        requestLocationPermission,
    required TResult orElse(),
  }) {
    if (checkLocationPermission != null) {
      return checkLocationPermission(this);
    }
    return orElse();
  }
}

abstract class _CheckLocationPermission implements PermissionEvent {
  const factory _CheckLocationPermission() = _$CheckLocationPermissionImpl;
}

/// @nodoc
abstract class _$$RequestLocationPermissionImplCopyWith<$Res> {
  factory _$$RequestLocationPermissionImplCopyWith(
          _$RequestLocationPermissionImpl value,
          $Res Function(_$RequestLocationPermissionImpl) then) =
      __$$RequestLocationPermissionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestLocationPermissionImplCopyWithImpl<$Res>
    extends _$PermissionEventCopyWithImpl<$Res, _$RequestLocationPermissionImpl>
    implements _$$RequestLocationPermissionImplCopyWith<$Res> {
  __$$RequestLocationPermissionImplCopyWithImpl(
      _$RequestLocationPermissionImpl _value,
      $Res Function(_$RequestLocationPermissionImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RequestLocationPermissionImpl implements _RequestLocationPermission {
  const _$RequestLocationPermissionImpl();

  @override
  String toString() {
    return 'PermissionEvent.requestLocationPermission()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestLocationPermissionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkLocationPermission,
    required TResult Function() requestLocationPermission,
  }) {
    return requestLocationPermission();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkLocationPermission,
    TResult? Function()? requestLocationPermission,
  }) {
    return requestLocationPermission?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkLocationPermission,
    TResult Function()? requestLocationPermission,
    required TResult orElse(),
  }) {
    if (requestLocationPermission != null) {
      return requestLocationPermission();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckLocationPermission value)
        checkLocationPermission,
    required TResult Function(_RequestLocationPermission value)
        requestLocationPermission,
  }) {
    return requestLocationPermission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckLocationPermission value)? checkLocationPermission,
    TResult? Function(_RequestLocationPermission value)?
        requestLocationPermission,
  }) {
    return requestLocationPermission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckLocationPermission value)? checkLocationPermission,
    TResult Function(_RequestLocationPermission value)?
        requestLocationPermission,
    required TResult orElse(),
  }) {
    if (requestLocationPermission != null) {
      return requestLocationPermission(this);
    }
    return orElse();
  }
}

abstract class _RequestLocationPermission implements PermissionEvent {
  const factory _RequestLocationPermission() = _$RequestLocationPermissionImpl;
}

/// @nodoc
mixin _$PermissionState {
  LocationState get locationState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PermissionStateCopyWith<PermissionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionStateCopyWith<$Res> {
  factory $PermissionStateCopyWith(
          PermissionState value, $Res Function(PermissionState) then) =
      _$PermissionStateCopyWithImpl<$Res, PermissionState>;
  @useResult
  $Res call({LocationState locationState});
}

/// @nodoc
class _$PermissionStateCopyWithImpl<$Res, $Val extends PermissionState>
    implements $PermissionStateCopyWith<$Res> {
  _$PermissionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationState = null,
  }) {
    return _then(_value.copyWith(
      locationState: null == locationState
          ? _value.locationState
          : locationState // ignore: cast_nullable_to_non_nullable
              as LocationState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PermissionStateImplCopyWith<$Res>
    implements $PermissionStateCopyWith<$Res> {
  factory _$$PermissionStateImplCopyWith(_$PermissionStateImpl value,
          $Res Function(_$PermissionStateImpl) then) =
      __$$PermissionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LocationState locationState});
}

/// @nodoc
class __$$PermissionStateImplCopyWithImpl<$Res>
    extends _$PermissionStateCopyWithImpl<$Res, _$PermissionStateImpl>
    implements _$$PermissionStateImplCopyWith<$Res> {
  __$$PermissionStateImplCopyWithImpl(
      _$PermissionStateImpl _value, $Res Function(_$PermissionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationState = null,
  }) {
    return _then(_$PermissionStateImpl(
      locationState: null == locationState
          ? _value.locationState
          : locationState // ignore: cast_nullable_to_non_nullable
              as LocationState,
    ));
  }
}

/// @nodoc

class _$PermissionStateImpl implements _PermissionState {
  const _$PermissionStateImpl(
      {this.locationState = LocationState.noPermission});

  @override
  @JsonKey()
  final LocationState locationState;

  @override
  String toString() {
    return 'PermissionState(locationState: $locationState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionStateImpl &&
            (identical(other.locationState, locationState) ||
                other.locationState == locationState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locationState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionStateImplCopyWith<_$PermissionStateImpl> get copyWith =>
      __$$PermissionStateImplCopyWithImpl<_$PermissionStateImpl>(
          this, _$identity);
}

abstract class _PermissionState implements PermissionState {
  const factory _PermissionState({final LocationState locationState}) =
      _$PermissionStateImpl;

  @override
  LocationState get locationState;
  @override
  @JsonKey(ignore: true)
  _$$PermissionStateImplCopyWith<_$PermissionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
