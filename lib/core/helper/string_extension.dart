// Utility to get month names
import 'package:flutter_metrics/core/app_imports.dart';

String monthName(int month) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return months[month - 1];
}


double calculateMaxY(List<OrderChartData> data) {
  // Get the maximum value from the data
  final maxY = data.map((item) => item.count).reduce((a, b) => a > b ? a : b);
  return maxY + (maxY * 0.1); // Add a 10% buffer
}

double calculateDynamicWidth(BuildContext context, int groupedDataLength) {
  final selectedTab = context.read<OrderCubit>().selectedTab;

  // Adjust width multiplier based on the selected tab
  switch (selectedTab) {
    case "WEEKS":
      return groupedDataLength * 40.0; // Default multiplier for Weeks
    case "MONTHS":
      return groupedDataLength * 50.0; // Slightly wider for Months
    case "QUARTERS":
      return groupedDataLength * 80.0; // Widest for Quarters
    default:
      return groupedDataLength * 40.0; // Fallback value
  }
}