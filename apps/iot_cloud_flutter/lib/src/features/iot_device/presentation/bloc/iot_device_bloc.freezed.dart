// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'iot_device_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$IotDeviceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({required TResult Function() list}) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({TResult? Function()? list}) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? list,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_List value) list,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_List value)? list,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_List value)? list,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IotDeviceEventCopyWith<$Res> {
  factory $IotDeviceEventCopyWith(
    IotDeviceEvent value,
    $Res Function(IotDeviceEvent) then,
  ) = _$IotDeviceEventCopyWithImpl<$Res, IotDeviceEvent>;
}

/// @nodoc
class _$IotDeviceEventCopyWithImpl<$Res, $Val extends IotDeviceEvent>
    implements $IotDeviceEventCopyWith<$Res> {
  _$IotDeviceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IotDeviceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ListImplCopyWith<$Res> {
  factory _$$ListImplCopyWith(
    _$ListImpl value,
    $Res Function(_$ListImpl) then,
  ) = __$$ListImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ListImplCopyWithImpl<$Res>
    extends _$IotDeviceEventCopyWithImpl<$Res, _$ListImpl>
    implements _$$ListImplCopyWith<$Res> {
  __$$ListImplCopyWithImpl(_$ListImpl _value, $Res Function(_$ListImpl) _then)
    : super(_value, _then);

  /// Create a copy of IotDeviceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ListImpl implements _List {
  const _$ListImpl();

  @override
  String toString() {
    return 'IotDeviceEvent.list()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({required TResult Function() list}) {
    return list();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({TResult? Function()? list}) {
    return list?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? list,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_List value) list,
  }) {
    return list(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_List value)? list,
  }) {
    return list?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_List value)? list,
    required TResult orElse(),
  }) {
    if (list != null) {
      return list(this);
    }
    return orElse();
  }
}

abstract class _List implements IotDeviceEvent {
  const factory _List() = _$ListImpl;
}

/// @nodoc
mixin _$IotDeviceBlocState {
  IotDeviceBlocStatus get status => throw _privateConstructorUsedError;
  List<IotDevice> get iotDevices => throw _privateConstructorUsedError;

  /// Create a copy of IotDeviceBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IotDeviceBlocStateCopyWith<IotDeviceBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IotDeviceBlocStateCopyWith<$Res> {
  factory $IotDeviceBlocStateCopyWith(
    IotDeviceBlocState value,
    $Res Function(IotDeviceBlocState) then,
  ) = _$IotDeviceBlocStateCopyWithImpl<$Res, IotDeviceBlocState>;
  @useResult
  $Res call({IotDeviceBlocStatus status, List<IotDevice> iotDevices});
}

/// @nodoc
class _$IotDeviceBlocStateCopyWithImpl<$Res, $Val extends IotDeviceBlocState>
    implements $IotDeviceBlocStateCopyWith<$Res> {
  _$IotDeviceBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IotDeviceBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? iotDevices = null}) {
    return _then(
      _value.copyWith(
            status:
                null == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as IotDeviceBlocStatus,
            iotDevices:
                null == iotDevices
                    ? _value.iotDevices
                    : iotDevices // ignore: cast_nullable_to_non_nullable
                        as List<IotDevice>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IotDeviceBlocStateImplCopyWith<$Res>
    implements $IotDeviceBlocStateCopyWith<$Res> {
  factory _$$IotDeviceBlocStateImplCopyWith(
    _$IotDeviceBlocStateImpl value,
    $Res Function(_$IotDeviceBlocStateImpl) then,
  ) = __$$IotDeviceBlocStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IotDeviceBlocStatus status, List<IotDevice> iotDevices});
}

/// @nodoc
class __$$IotDeviceBlocStateImplCopyWithImpl<$Res>
    extends _$IotDeviceBlocStateCopyWithImpl<$Res, _$IotDeviceBlocStateImpl>
    implements _$$IotDeviceBlocStateImplCopyWith<$Res> {
  __$$IotDeviceBlocStateImplCopyWithImpl(
    _$IotDeviceBlocStateImpl _value,
    $Res Function(_$IotDeviceBlocStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IotDeviceBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? iotDevices = null}) {
    return _then(
      _$IotDeviceBlocStateImpl(
        status:
            null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as IotDeviceBlocStatus,
        iotDevices:
            null == iotDevices
                ? _value._iotDevices
                : iotDevices // ignore: cast_nullable_to_non_nullable
                    as List<IotDevice>,
      ),
    );
  }
}

/// @nodoc

class _$IotDeviceBlocStateImpl implements _IotDeviceBlocState {
  const _$IotDeviceBlocStateImpl({
    this.status = IotDeviceBlocStatus.initial,
    final List<IotDevice> iotDevices = const [],
  }) : _iotDevices = iotDevices;

  @override
  @JsonKey()
  final IotDeviceBlocStatus status;
  final List<IotDevice> _iotDevices;
  @override
  @JsonKey()
  List<IotDevice> get iotDevices {
    if (_iotDevices is EqualUnmodifiableListView) return _iotDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_iotDevices);
  }

  @override
  String toString() {
    return 'IotDeviceBlocState(status: $status, iotDevices: $iotDevices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IotDeviceBlocStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._iotDevices,
              _iotDevices,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_iotDevices),
  );

  /// Create a copy of IotDeviceBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IotDeviceBlocStateImplCopyWith<_$IotDeviceBlocStateImpl> get copyWith =>
      __$$IotDeviceBlocStateImplCopyWithImpl<_$IotDeviceBlocStateImpl>(
        this,
        _$identity,
      );
}

abstract class _IotDeviceBlocState implements IotDeviceBlocState {
  const factory _IotDeviceBlocState({
    final IotDeviceBlocStatus status,
    final List<IotDevice> iotDevices,
  }) = _$IotDeviceBlocStateImpl;

  @override
  IotDeviceBlocStatus get status;
  @override
  List<IotDevice> get iotDevices;

  /// Create a copy of IotDeviceBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IotDeviceBlocStateImplCopyWith<_$IotDeviceBlocStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
