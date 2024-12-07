// lib/core/usecases/usecase.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_metrics/core/app_imports.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
