// lib/domain/entities/my_order.dart
import 'package:flutter_metrics/core/app_imports.dart';

class MyOrder extends Equatable {
  final String id;
  final double price;
  final DateTime date;
  final bool isReturned;

  const MyOrder({
    required this.id,
    required this.price,
    required this.date,
    required this.isReturned,
  });

  @override
  List<Object?> get props => [id, price, date, isReturned];
}
