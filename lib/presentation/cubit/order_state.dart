part of 'order_cubit.dart';


abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  final Map<String, dynamic> metrics;
  final List<OrderChartData> groupedData;

  OrderLoaded({
    required this.orders,
    required this.metrics,
    required this.groupedData,
  });
}

class OrderError extends OrderState {
  final String message;

  OrderError({required this.message});
}
