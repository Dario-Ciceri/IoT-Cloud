import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();

  /// Network related failures
  const factory Failure.network({
    required String message,
    String? stackTrace,
    int? statusCode,
  }) = NetworkFailure;

  /// Server related failures
  const factory Failure.server({
    required String message,
    String? stackTrace,
    int? statusCode,
  }) = ServerFailure;

  /// Cache related failures
  const factory Failure.cache({required String message, String? stackTrace}) =
      CacheFailure;

  /// Validation related failures
  const factory Failure.validation({
    required String message,
    Map<String, List<String>>? errors,
    String? stackTrace,
  }) = ValidationFailure;

  /// Authentication related failures
  const factory Failure.auth({
    required String message,
    String? stackTrace,
    int? statusCode,
  }) = AuthFailure;

  /// Permission related failures
  const factory Failure.permission({
    required String message,
    String? stackTrace,
  }) = PermissionFailure;

  /// Unexpected failures
  const factory Failure.unexpected({
    required String message,
    String? stackTrace,
  }) = UnexpectedFailure;

  /// Helper method to create a Failure from any exception
  static Failure fromException(Exception exception, [StackTrace? stackTrace]) {
    return Failure.unexpected(
      message: exception.toString(),
      stackTrace: stackTrace?.toString(),
    );
  }

  /// Helper for getting a debug message
  String get debugMessage => when(
    network:
        (message, _, __) =>
            'Errore di rete: verificare la connessione al server.',
    server:
        (message, _, statusCode) =>
            'Errore server${statusCode != null ? ' ($statusCode)' : ''}.',
    cache: (message, _) => 'Data loading error',
    validation:
        (message, errors, _) =>
            errors?.values.expand((e) => e).join(', ') ?? message,
    auth: (message, _, __) => 'Authentication error',
    permission: (message, _) => 'Permission denied',
    unexpected: (message, _) => 'An unexpected error occurred',
  );
}
