import 'package:equatable/equatable.dart';

/// Machine-readable reason a use case failed.
///
/// The UI maps this to a localised message; failures never carry user-facing
/// strings, so copy lives in the ARB files only.
enum FailureCode {
  permission,
  locationUnavailable,
  storage,
  validation,
  unknown,
}

/// Base type for everything that can go wrong below the presentation layer.
sealed class Failure extends Equatable {
  const Failure(this.code, {this.cause});

  final FailureCode code;

  /// The original error or exception, kept for logging only.
  final Object? cause;

  @override
  List<Object?> get props => [code, cause];
}

final class PermissionFailure extends Failure {
  const PermissionFailure({super.cause}) : super(FailureCode.permission);
}

final class LocationUnavailableFailure extends Failure {
  const LocationUnavailableFailure({super.cause})
    : super(FailureCode.locationUnavailable);
}

final class StorageFailure extends Failure {
  const StorageFailure({super.cause}) : super(FailureCode.storage);
}

final class ValidationFailure extends Failure {
  const ValidationFailure({super.cause}) : super(FailureCode.validation);
}

final class UnknownFailure extends Failure {
  const UnknownFailure({super.cause}) : super(FailureCode.unknown);
}
