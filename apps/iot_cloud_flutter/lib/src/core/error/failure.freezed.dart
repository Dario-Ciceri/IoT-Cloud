// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  String? get stackTrace => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    network,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    server,
    required TResult Function(String message, String? stackTrace) cache,
    required TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )
    validation,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    auth,
    required TResult Function(String message, String? stackTrace) permission,
    required TResult Function(String message, String? stackTrace) unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult? Function(String message, String? stackTrace)? cache,
    TResult? Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    auth,
    TResult? Function(String message, String? stackTrace)? permission,
    TResult? Function(String message, String? stackTrace)? unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult Function(String message, String? stackTrace)? cache,
    TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult Function(String message, String? stackTrace, int? statusCode)? auth,
    TResult Function(String message, String? stackTrace)? permission,
    TResult Function(String message, String? stackTrace)? unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(AuthFailure value)? auth,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message, String? stackTrace});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? stackTrace = freezed}) {
    return _then(
      _value.copyWith(
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            stackTrace:
                freezed == stackTrace
                    ? _value.stackTrace
                    : stackTrace // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(
    _$NetworkFailureImpl value,
    $Res Function(_$NetworkFailureImpl) then,
  ) = __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? stackTrace, int? statusCode});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
    _$NetworkFailureImpl _value,
    $Res Function(_$NetworkFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? stackTrace = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$NetworkFailureImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        stackTrace:
            freezed == stackTrace
                ? _value.stackTrace
                : stackTrace // ignore: cast_nullable_to_non_nullable
                    as String?,
        statusCode:
            freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc

class _$NetworkFailureImpl extends NetworkFailure {
  const _$NetworkFailureImpl({
    required this.message,
    this.stackTrace,
    this.statusCode,
  }) : super._();

  @override
  final String message;
  @override
  final String? stackTrace;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'Failure.network(message: $message, stackTrace: $stackTrace, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, stackTrace, statusCode);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    network,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    server,
    required TResult Function(String message, String? stackTrace) cache,
    required TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )
    validation,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    auth,
    required TResult Function(String message, String? stackTrace) permission,
    required TResult Function(String message, String? stackTrace) unexpected,
  }) {
    return network(message, stackTrace, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult? Function(String message, String? stackTrace)? cache,
    TResult? Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    auth,
    TResult? Function(String message, String? stackTrace)? permission,
    TResult? Function(String message, String? stackTrace)? unexpected,
  }) {
    return network?.call(message, stackTrace, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult Function(String message, String? stackTrace)? cache,
    TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult Function(String message, String? stackTrace, int? statusCode)? auth,
    TResult Function(String message, String? stackTrace)? permission,
    TResult Function(String message, String? stackTrace)? unexpected,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message, stackTrace, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(AuthFailure value)? auth,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure extends Failure {
  const factory NetworkFailure({
    required final String message,
    final String? stackTrace,
    final int? statusCode,
  }) = _$NetworkFailureImpl;
  const NetworkFailure._() : super._();

  @override
  String get message;
  @override
  String? get stackTrace;
  int? get statusCode;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
    _$ServerFailureImpl value,
    $Res Function(_$ServerFailureImpl) then,
  ) = __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? stackTrace, int? statusCode});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
    _$ServerFailureImpl _value,
    $Res Function(_$ServerFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? stackTrace = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$ServerFailureImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        stackTrace:
            freezed == stackTrace
                ? _value.stackTrace
                : stackTrace // ignore: cast_nullable_to_non_nullable
                    as String?,
        statusCode:
            freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc

class _$ServerFailureImpl extends ServerFailure {
  const _$ServerFailureImpl({
    required this.message,
    this.stackTrace,
    this.statusCode,
  }) : super._();

  @override
  final String message;
  @override
  final String? stackTrace;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'Failure.server(message: $message, stackTrace: $stackTrace, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, stackTrace, statusCode);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    network,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    server,
    required TResult Function(String message, String? stackTrace) cache,
    required TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )
    validation,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    auth,
    required TResult Function(String message, String? stackTrace) permission,
    required TResult Function(String message, String? stackTrace) unexpected,
  }) {
    return server(message, stackTrace, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult? Function(String message, String? stackTrace)? cache,
    TResult? Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    auth,
    TResult? Function(String message, String? stackTrace)? permission,
    TResult? Function(String message, String? stackTrace)? unexpected,
  }) {
    return server?.call(message, stackTrace, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult Function(String message, String? stackTrace)? cache,
    TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult Function(String message, String? stackTrace, int? statusCode)? auth,
    TResult Function(String message, String? stackTrace)? permission,
    TResult Function(String message, String? stackTrace)? unexpected,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message, stackTrace, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(AuthFailure value)? auth,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerFailure extends Failure {
  const factory ServerFailure({
    required final String message,
    final String? stackTrace,
    final int? statusCode,
  }) = _$ServerFailureImpl;
  const ServerFailure._() : super._();

  @override
  String get message;
  @override
  String? get stackTrace;
  int? get statusCode;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CacheFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$CacheFailureImplCopyWith(
    _$CacheFailureImpl value,
    $Res Function(_$CacheFailureImpl) then,
  ) = __$$CacheFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? stackTrace});
}

/// @nodoc
class __$$CacheFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$CacheFailureImpl>
    implements _$$CacheFailureImplCopyWith<$Res> {
  __$$CacheFailureImplCopyWithImpl(
    _$CacheFailureImpl _value,
    $Res Function(_$CacheFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? stackTrace = freezed}) {
    return _then(
      _$CacheFailureImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        stackTrace:
            freezed == stackTrace
                ? _value.stackTrace
                : stackTrace // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$CacheFailureImpl extends CacheFailure {
  const _$CacheFailureImpl({required this.message, this.stackTrace})
    : super._();

  @override
  final String message;
  @override
  final String? stackTrace;

  @override
  String toString() {
    return 'Failure.cache(message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, stackTrace);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      __$$CacheFailureImplCopyWithImpl<_$CacheFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    network,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    server,
    required TResult Function(String message, String? stackTrace) cache,
    required TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )
    validation,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    auth,
    required TResult Function(String message, String? stackTrace) permission,
    required TResult Function(String message, String? stackTrace) unexpected,
  }) {
    return cache(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult? Function(String message, String? stackTrace)? cache,
    TResult? Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    auth,
    TResult? Function(String message, String? stackTrace)? permission,
    TResult? Function(String message, String? stackTrace)? unexpected,
  }) {
    return cache?.call(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult Function(String message, String? stackTrace)? cache,
    TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult Function(String message, String? stackTrace, int? statusCode)? auth,
    TResult Function(String message, String? stackTrace)? permission,
    TResult Function(String message, String? stackTrace)? unexpected,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return cache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return cache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(AuthFailure value)? auth,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(this);
    }
    return orElse();
  }
}

abstract class CacheFailure extends Failure {
  const factory CacheFailure({
    required final String message,
    final String? stackTrace,
  }) = _$CacheFailureImpl;
  const CacheFailure._() : super._();

  @override
  String get message;
  @override
  String? get stackTrace;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(
    _$ValidationFailureImpl value,
    $Res Function(_$ValidationFailureImpl) then,
  ) = __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    Map<String, List<String>>? errors,
    String? stackTrace,
  });
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(
    _$ValidationFailureImpl _value,
    $Res Function(_$ValidationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? errors = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(
      _$ValidationFailureImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        errors:
            freezed == errors
                ? _value._errors
                : errors // ignore: cast_nullable_to_non_nullable
                    as Map<String, List<String>>?,
        stackTrace:
            freezed == stackTrace
                ? _value.stackTrace
                : stackTrace // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$ValidationFailureImpl extends ValidationFailure {
  const _$ValidationFailureImpl({
    required this.message,
    final Map<String, List<String>>? errors,
    this.stackTrace,
  }) : _errors = errors,
       super._();

  @override
  final String message;
  final Map<String, List<String>>? _errors;
  @override
  Map<String, List<String>>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? stackTrace;

  @override
  String toString() {
    return 'Failure.validation(message: $message, errors: $errors, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_errors),
    stackTrace,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    network,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    server,
    required TResult Function(String message, String? stackTrace) cache,
    required TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )
    validation,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    auth,
    required TResult Function(String message, String? stackTrace) permission,
    required TResult Function(String message, String? stackTrace) unexpected,
  }) {
    return validation(message, errors, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult? Function(String message, String? stackTrace)? cache,
    TResult? Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    auth,
    TResult? Function(String message, String? stackTrace)? permission,
    TResult? Function(String message, String? stackTrace)? unexpected,
  }) {
    return validation?.call(message, errors, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult Function(String message, String? stackTrace)? cache,
    TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult Function(String message, String? stackTrace, int? statusCode)? auth,
    TResult Function(String message, String? stackTrace)? permission,
    TResult Function(String message, String? stackTrace)? unexpected,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, errors, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(AuthFailure value)? auth,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure extends Failure {
  const factory ValidationFailure({
    required final String message,
    final Map<String, List<String>>? errors,
    final String? stackTrace,
  }) = _$ValidationFailureImpl;
  const ValidationFailure._() : super._();

  @override
  String get message;
  Map<String, List<String>>? get errors;
  @override
  String? get stackTrace;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AuthFailureImplCopyWith(
    _$AuthFailureImpl value,
    $Res Function(_$AuthFailureImpl) then,
  ) = __$$AuthFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? stackTrace, int? statusCode});
}

/// @nodoc
class __$$AuthFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthFailureImpl>
    implements _$$AuthFailureImplCopyWith<$Res> {
  __$$AuthFailureImplCopyWithImpl(
    _$AuthFailureImpl _value,
    $Res Function(_$AuthFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? stackTrace = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$AuthFailureImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        stackTrace:
            freezed == stackTrace
                ? _value.stackTrace
                : stackTrace // ignore: cast_nullable_to_non_nullable
                    as String?,
        statusCode:
            freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc

class _$AuthFailureImpl extends AuthFailure {
  const _$AuthFailureImpl({
    required this.message,
    this.stackTrace,
    this.statusCode,
  }) : super._();

  @override
  final String message;
  @override
  final String? stackTrace;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'Failure.auth(message: $message, stackTrace: $stackTrace, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, stackTrace, statusCode);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      __$$AuthFailureImplCopyWithImpl<_$AuthFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    network,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    server,
    required TResult Function(String message, String? stackTrace) cache,
    required TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )
    validation,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    auth,
    required TResult Function(String message, String? stackTrace) permission,
    required TResult Function(String message, String? stackTrace) unexpected,
  }) {
    return auth(message, stackTrace, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult? Function(String message, String? stackTrace)? cache,
    TResult? Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    auth,
    TResult? Function(String message, String? stackTrace)? permission,
    TResult? Function(String message, String? stackTrace)? unexpected,
  }) {
    return auth?.call(message, stackTrace, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult Function(String message, String? stackTrace)? cache,
    TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult Function(String message, String? stackTrace, int? statusCode)? auth,
    TResult Function(String message, String? stackTrace)? permission,
    TResult Function(String message, String? stackTrace)? unexpected,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(message, stackTrace, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return auth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return auth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(AuthFailure value)? auth,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(this);
    }
    return orElse();
  }
}

abstract class AuthFailure extends Failure {
  const factory AuthFailure({
    required final String message,
    final String? stackTrace,
    final int? statusCode,
  }) = _$AuthFailureImpl;
  const AuthFailure._() : super._();

  @override
  String get message;
  @override
  String? get stackTrace;
  int? get statusCode;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$PermissionFailureImplCopyWith(
    _$PermissionFailureImpl value,
    $Res Function(_$PermissionFailureImpl) then,
  ) = __$$PermissionFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? stackTrace});
}

/// @nodoc
class __$$PermissionFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$PermissionFailureImpl>
    implements _$$PermissionFailureImplCopyWith<$Res> {
  __$$PermissionFailureImplCopyWithImpl(
    _$PermissionFailureImpl _value,
    $Res Function(_$PermissionFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? stackTrace = freezed}) {
    return _then(
      _$PermissionFailureImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        stackTrace:
            freezed == stackTrace
                ? _value.stackTrace
                : stackTrace // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$PermissionFailureImpl extends PermissionFailure {
  const _$PermissionFailureImpl({required this.message, this.stackTrace})
    : super._();

  @override
  final String message;
  @override
  final String? stackTrace;

  @override
  String toString() {
    return 'Failure.permission(message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, stackTrace);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      __$$PermissionFailureImplCopyWithImpl<_$PermissionFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    network,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    server,
    required TResult Function(String message, String? stackTrace) cache,
    required TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )
    validation,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    auth,
    required TResult Function(String message, String? stackTrace) permission,
    required TResult Function(String message, String? stackTrace) unexpected,
  }) {
    return permission(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult? Function(String message, String? stackTrace)? cache,
    TResult? Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    auth,
    TResult? Function(String message, String? stackTrace)? permission,
    TResult? Function(String message, String? stackTrace)? unexpected,
  }) {
    return permission?.call(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult Function(String message, String? stackTrace)? cache,
    TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult Function(String message, String? stackTrace, int? statusCode)? auth,
    TResult Function(String message, String? stackTrace)? permission,
    TResult Function(String message, String? stackTrace)? unexpected,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return permission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return permission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(AuthFailure value)? auth,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(this);
    }
    return orElse();
  }
}

abstract class PermissionFailure extends Failure {
  const factory PermissionFailure({
    required final String message,
    final String? stackTrace,
  }) = _$PermissionFailureImpl;
  const PermissionFailure._() : super._();

  @override
  String get message;
  @override
  String? get stackTrace;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnexpectedFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnexpectedFailureImplCopyWith(
    _$UnexpectedFailureImpl value,
    $Res Function(_$UnexpectedFailureImpl) then,
  ) = __$$UnexpectedFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? stackTrace});
}

/// @nodoc
class __$$UnexpectedFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnexpectedFailureImpl>
    implements _$$UnexpectedFailureImplCopyWith<$Res> {
  __$$UnexpectedFailureImplCopyWithImpl(
    _$UnexpectedFailureImpl _value,
    $Res Function(_$UnexpectedFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? stackTrace = freezed}) {
    return _then(
      _$UnexpectedFailureImpl(
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        stackTrace:
            freezed == stackTrace
                ? _value.stackTrace
                : stackTrace // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$UnexpectedFailureImpl extends UnexpectedFailure {
  const _$UnexpectedFailureImpl({required this.message, this.stackTrace})
    : super._();

  @override
  final String message;
  @override
  final String? stackTrace;

  @override
  String toString() {
    return 'Failure.unexpected(message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnexpectedFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, stackTrace);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnexpectedFailureImplCopyWith<_$UnexpectedFailureImpl> get copyWith =>
      __$$UnexpectedFailureImplCopyWithImpl<_$UnexpectedFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    network,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    server,
    required TResult Function(String message, String? stackTrace) cache,
    required TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )
    validation,
    required TResult Function(
      String message,
      String? stackTrace,
      int? statusCode,
    )
    auth,
    required TResult Function(String message, String? stackTrace) permission,
    required TResult Function(String message, String? stackTrace) unexpected,
  }) {
    return unexpected(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult? Function(String message, String? stackTrace)? cache,
    TResult? Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult? Function(String message, String? stackTrace, int? statusCode)?
    auth,
    TResult? Function(String message, String? stackTrace)? permission,
    TResult? Function(String message, String? stackTrace)? unexpected,
  }) {
    return unexpected?.call(message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, String? stackTrace, int? statusCode)?
    network,
    TResult Function(String message, String? stackTrace, int? statusCode)?
    server,
    TResult Function(String message, String? stackTrace)? cache,
    TResult Function(
      String message,
      Map<String, List<String>>? errors,
      String? stackTrace,
    )?
    validation,
    TResult Function(String message, String? stackTrace, int? statusCode)? auth,
    TResult Function(String message, String? stackTrace)? permission,
    TResult Function(String message, String? stackTrace)? unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnexpectedFailure value) unexpected,
  }) {
    return unexpected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnexpectedFailure value)? unexpected,
  }) {
    return unexpected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(AuthFailure value)? auth,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnexpectedFailure value)? unexpected,
    required TResult orElse(),
  }) {
    if (unexpected != null) {
      return unexpected(this);
    }
    return orElse();
  }
}

abstract class UnexpectedFailure extends Failure {
  const factory UnexpectedFailure({
    required final String message,
    final String? stackTrace,
  }) = _$UnexpectedFailureImpl;
  const UnexpectedFailure._() : super._();

  @override
  String get message;
  @override
  String? get stackTrace;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnexpectedFailureImplCopyWith<_$UnexpectedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
