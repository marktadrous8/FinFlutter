// Build bar groups for the bar chart
import 'package:flutter_metrics/core/app_imports.dart';

List<BarChartGroupData> buildBarGroups(List<OrderChartData> data) {
  return data.asMap().entries.map((entry) {
    final index = entry.key;
    final item = entry.value;

    return BarChartGroupData(
      x: index, // X-axis value
      barRods: [
        BarChartRodData(
          toY: item.count.toDouble(), // Height of the bar
          width: 20, // Adjust the bar width (default is 20)
          color: Colors.blue, // Bar color
        ),
      ],
    );
  }).toList();
}