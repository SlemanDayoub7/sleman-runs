import 'package:fpdart/fpdart.dart';
import 'package:sleman_runs/core/error/failure.dart';

/// The outcome of an operation that can fail in a domain-meaningful way.
///
/// Use cases return this instead of throwing, so every caller is forced to
/// handle the failure path at compile time.
typedef Result<T> = Either<Failure, T>;

/// Success constructor.
Result<T> ok<T>(T value) => Right<Failure, T>(value);

/// Failure constructor.
Result<T> err<T>(Failure failure) => Left<Failure, T>(failure);
