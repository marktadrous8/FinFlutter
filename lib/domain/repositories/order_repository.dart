// lib/domain/repositories/order_repository.dart
import 'package:flutter_metrics/core/app_imports.dart';
import 'package:dartz/dartz.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderModel>>> getAllOrders();
}
