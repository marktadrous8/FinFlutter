// lib/data/repositories/order_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_metrics/core/app_imports.dart';

class OrderRepositoryImpl implements OrderRepository {
  final LocalOrderDataSource localDataSource;

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<OrderModel>>> getAllOrders() async {
    try {
      final orders = await localDataSource.getOrdersFromJson();
      return Right(orders);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }
}
