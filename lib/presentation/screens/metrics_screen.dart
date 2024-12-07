import 'package:flutter_metrics/core/app_imports.dart';


class MetricsScreen extends StatelessWidget {
  const MetricsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderCubit orderCubit = getIt<OrderCubit>();

    return  BlocProvider.value(
      value: orderCubit..fetchOrders(),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            final metrics = state.metrics;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MetricCard(title: "Total Orders", value: "${metrics['totalCount']}"),
                  MetricCard(
                    title: "Average Price",
                    value: "\$${metrics['averagePrice'].toStringAsFixed(2)}",
                  ),
                  MetricCard(title: "Returns", value: "${metrics['returnCount']}"),
                ],
              ),
            );
          } else if (state is OrderError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is OrderInitial) {
            return const Center(child: Text("No data loaded yet."));
          } else {
            return const Center(
              child: Text(
                "Something went wrong.",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        },
      ),
    );
  }
}

