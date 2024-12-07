// lib/domain/usecases/get_all_orders.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_metrics/core/app_imports.dart';

class GetAllOrders implements UseCase<List<OrderModel>, NoParams> {
  final OrderRepository repository;

  GetAllOrders(this.repository);

  @override
  Future<Either<Failure, List<OrderModel>>> call(NoParams params) async {
    return await repository.getAllOrders();
  }
}
