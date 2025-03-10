// import 'package:iot_cloud_flutter/src/core/error/failure.dart';

// // Classe base per tutte le eccezioni dell'applicazione
// abstract class AppException implements Exception {
//   final String message;
//   final String? stackTrace;

//   const AppException(this.message, [this.stackTrace]);

//   @override
//   String toString() => message;
// }

// // Eccezioni di rete
// class NetworkException extends AppException {
//   final int? statusCode;

//   const NetworkException(super.message, [super.stackTrace, this.statusCode]);

//   @override
//   String toString() {
//     if (statusCode != null) {
//       return 'NetworkException: $message ${' (Status: $statusCode)'}';
//     }
//     return 'NetworkException: $message';
//   }
// }

// // Eccezioni del server
// class ServerException extends AppException {
//   final int? statusCode;

//   const ServerException(super.message, [super.stackTrace, this.statusCode]);

//   @override
//   String toString() {
//     if (statusCode != null) {
//       return 'ServerException: $message ${' (Status: $statusCode)'}';
//     }
//     return 'ServerException: $message';
//   }
// }

// // Eccezioni di cache
// class CacheException extends AppException {
//   const CacheException(super.message, [super.stackTrace]);

//   @override
//   String toString() {
//     return 'CacheException: $message';
//   }
// }

// // Eccezioni di validazione
// class ValidationException extends AppException {
//   final Map<String, List<String>>? errors;

//   const ValidationException(super.message, [this.errors, super.stackTrace]);

//   String get formattedErrors =>
//       errors?.entries
//           .map((e) => '${e.key}: ${e.value.join(', ')}')
//           .join('\n') ??
//       '';

//   @override
//   String toString() {
//     if (errors != null) {
//       return 'ValidationException: $message ${'\nErrors: $formattedErrors'}';
//     }
//     return 'ValidationException: $message';
//   }
// }

// // Eccezioni di autenticazione
// class AuthException extends AppException {
//   final int? statusCode;

//   const AuthException(super.message, [super.stackTrace, this.statusCode]);

//   @override
//   String toString() {
//     if (statusCode != null) {
//       return 'AuthException: $message ${' (Status: $statusCode)'}';
//     }
//     return 'AuthException: $message';
//   }
// }

// // Eccezioni di permessi
// class PermissionException extends AppException {
//   const PermissionException(super.message, [super.stackTrace]);

//   @override
//   String toString() {
//     return 'PermissionException: $message';
//   }
// }

// // Eccezioni inaspettate
// class UnexpectedException extends AppException {
//   const UnexpectedException(super.message, [super.stackTrace]);

//   @override
//   String toString() {
//     return 'UnexpectedException: $message';
//   }

//   // Crea un'eccezione da qualsiasi errore
//   static UnexpectedException fromError(dynamic error,
//       [StackTrace? stackTrace]) {
//     return UnexpectedException(
//       error.toString(),
//       stackTrace?.toString(),
//     );
//   }
// }

// // Utility per convertire Exception in Failure
// extension ExceptionToFailureX on AppException {
//   Failure toFailure() {
//     if (this is NetworkException) {
//       final exception = this as NetworkException;
//       return Failure.network(
//         message: exception.message,
//         stackTrace: exception.stackTrace,
//         statusCode: exception.statusCode,
//       );
//     } else if (this is ServerException) {
//       final exception = this as ServerException;
//       return Failure.server(
//         message: exception.message,
//         stackTrace: exception.stackTrace,
//         statusCode: exception.statusCode,
//       );
//     } else if (this is CacheException) {
//       return Failure.cache(
//         message: message,
//         stackTrace: stackTrace,
//       );
//     } else if (this is ValidationException) {
//       final exception = this as ValidationException;
//       return Failure.validation(
//         message: exception.message,
//         errors: exception.errors,
//         stackTrace: exception.stackTrace,
//       );
//     } else if (this is AuthException) {
//       final exception = this as AuthException;
//       return Failure.auth(
//         message: exception.message,
//         stackTrace: exception.stackTrace,
//         statusCode: exception.statusCode,
//       );
//     } else if (this is PermissionException) {
//       return Failure.permission(
//         message: message,
//         stackTrace: stackTrace,
//       );
//     } else {
//       return Failure.unexpected(
//         message: message,
//         stackTrace: stackTrace,
//       );
//     }
//   }
// }
