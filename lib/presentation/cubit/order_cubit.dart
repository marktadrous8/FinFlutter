// lib/presentation/cubit/order_cubit.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_metrics/core/app_imports.dart';
import 'package:intl/intl.dart';
part 'order_state.dart';


class OrderCubit extends Cubit<OrderState> {
  final GetAllOrders getAllOrders;

  String selectedFilter = "ALL";
  String selectedTab = "WEEKS";

  OrderCubit({required this.getAllOrders}) : super(OrderInitial());

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    print("Fetching orders...");

    Either<Failure, List<OrderModel>> eitherResponse = await getAllOrders(NoParams());

    eitherResponse.fold(
          (failure) {
        print("Error: ${failure.message}");
        emit(OrderError(message: failure.message));
      },
          (orders) {
        if (orders.isEmpty) {
          print("No orders found.");
          emit(OrderError(message: "No orders available."));
          return;
        }

        print("Orders fetched: ${orders.length}");
        // Calculate metrics
        final metrics = calculateMetrics(orders);
        // Grouped data for the graph
        final groupedData = groupOrders(orders);

        emit(OrderLoaded(
          orders: orders,
          metrics: metrics,
          groupedData: groupedData,
        ));
      },
    );
  }

  // Group orders based on filters
  // Group orders based on filters and selected tab
  List<OrderChartData> groupOrders(List<OrderModel> orders) {
    final filteredOrders = selectedFilter == "ALL"
        ? orders
        : orders.where((order) => order.status == selectedFilter).toList();

    final Map<DateTime, int> groupedData = {};

    // Populate groupedData as before
    for (var order in filteredOrders) {
      DateTime groupKey;
      switch (selectedTab) {
        case "MONTHS":
          groupKey = DateTime(order.registered.year, order.registered.month);
          break;
        case "QUARTERS":
          final quarter = ((order.registered.month - 1) / 3).floor() + 1;
          final quarterStartMonth = (quarter - 1) * 3 + 1;
          groupKey = DateTime(order.registered.year, quarterStartMonth);
          break;
        case "WEEKS":
          final startOfYear = DateTime(order.registered.year, 1, 1);
          final weekStart = order.registered.subtract(Duration(days: order.registered.weekday - 1));
          final daysPassed = weekStart.difference(startOfYear).inDays;
          final weekNumber = (daysPassed ~/ 7) + 1;
          groupKey = DateTime(order.registered.year).add(Duration(days: (weekNumber - 1) * 7));
          break;
        default:
          final weekStart = order.registered.subtract(
              Duration(days: order.registered.weekday - 1));
          groupKey = DateTime(weekStart.year, weekStart.month, weekStart.day);
      }

      groupedData.update(groupKey, (value) => value + 1, ifAbsent: () => 1);
    }

    // If no orders, return empty
    if (filteredOrders.isEmpty) return [];

    // Only fill missing weeks if selectedTab is WEEKS and we have data
    if (selectedTab == "WEEKS" && groupedData.isNotEmpty) {
      // Determine the actual earliest and latest keys from groupedData
      final earliestWeek = groupedData.keys.reduce((a, b) => a.isBefore(b) ? a : b);
      final latestWeek = groupedData.keys.reduce((a, b) => a.isAfter(b) ? a : b);

      // Fill in missing weeks between earliestWeek and latestWeek
      DateTime currentWeek = earliestWeek;
      while (!currentWeek.isAfter(latestWeek)) {
        if (!groupedData.containsKey(currentWeek)) {
          groupedData[currentWeek] = 0;
        }
        currentWeek = currentWeek.add(const Duration(days: 7));
      }
    }

    final sortedKeys = groupedData.keys.toList()..sort();

    return sortedKeys
        .map((key) => OrderChartData(date: key, count: groupedData[key]!))
        .toList();
  }

  // Calculate metrics
  Map<String, dynamic> calculateMetrics(List<OrderModel> orders) {
    final totalCount = orders.length;
    final averagePrice = orders.isNotEmpty
        ? orders.map((order) => order.price).reduce((a, b) => a + b) / totalCount
        : 0.0;
    final returnCount = orders.where((order) => order.status == "RETURNED").length;

    return {
      "totalCount": totalCount,
      "averagePrice": averagePrice,
      "returnCount": returnCount,
    };
  }


  // Update tab filter
  void updateTab(String tab) {
    selectedTab = tab;
    if (state is OrderLoaded) {
      final orders = (state as OrderLoaded).orders;
      emit(OrderLoaded(
        orders: orders,
        metrics: calculateMetrics(orders),
        groupedData: groupOrders(orders), // Recalculate groupedData
      ));
    }
  }



  int  getWeekOfYear(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final daysPassed = date.difference(startOfYear).inDays;
    return (daysPassed / 7).ceil();
  }

  String  getMonthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }


}
