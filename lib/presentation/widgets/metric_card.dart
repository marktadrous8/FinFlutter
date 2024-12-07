// lib/presentation/widgets/metric_card.dart
import 'package:flutter_metrics/core/app_imports.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;

  const MetricCard({required this.title, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}