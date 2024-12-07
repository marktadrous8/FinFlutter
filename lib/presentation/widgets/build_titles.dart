import 'package:flutter_metrics/core/app_imports.dart';
import 'package:intl/intl.dart';
FlTitlesData buildTitles(OrderState state, BuildContext context) {
  return FlTitlesData(
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false), // Y-axis handled separately
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, meta) {
          if (state is OrderLoaded) {
            final groupedData = state.groupedData;
            final selectedTab = context.read<OrderCubit>().selectedTab;

            if (value.toInt() >= 0 && value.toInt() < groupedData.length) {
              if (selectedTab == "WEEKS") {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "W${value.toInt() + 1}",
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              } else if (selectedTab == "MONTHS") {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    DateFormat('MMM').format(groupedData[value.toInt()].date),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              } else if (selectedTab == "QUARTERS") {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "Q${((groupedData[value.toInt()].date.month - 1) ~/ 3) + 1}",
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              }
            }
          }
          return const SizedBox.shrink(); // Avoid duplication of invalid or extra values
        },
      ),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );
}
AxisTitles buildLeftTitles(OrderState state) {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      interval: 1,
      reservedSize: 40, // Ensure enough space for labels
      getTitlesWidget: (value, meta) {
        // Skip rendering the top-most duplicated value
        if (value == meta.max) {
          return const SizedBox.shrink(); // Avoid duplication of the last label
        }

        return Padding(
          padding: const EdgeInsets.only(right: 8.0), // Adjust padding for alignment
          child: Text(
            value.toInt().toString(),
            style: const TextStyle(fontSize: 10),
          ),
        );
      },
    ),
  );
}