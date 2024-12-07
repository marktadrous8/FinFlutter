import 'package:flutter_metrics/core/app_imports.dart';

class FilterDropdown extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const FilterDropdown({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        value: selectedFilter,
        onChanged: (value) {
          if (value != null) onFilterChanged(value);
        },
        items: ["ALL", "Week", "Month", "Quarter"]
            .map((filter) => DropdownMenuItem<String>(
          value: filter,
          child: Text(filter),
        ))
            .toList(),
      ),
    );
  }
}
