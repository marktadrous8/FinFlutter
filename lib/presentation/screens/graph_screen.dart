import 'package:flutter_metrics/core/app_imports.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderCubit orderCubit = getIt<OrderCubit>();

    return BlocProvider.value(
      value: orderCubit..fetchOrders(),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            if (state.groupedData.isEmpty) {
              return const Center(child: Text("No data available."));
            }

            return DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  // TabBar
                  Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Filter by",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBar(
                            dividerHeight: 0,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Colors.transparent,
                            tabs: const [
                              Tab(text: "Weeks"),
                              Tab(text: "Months"),
                              Tab(text: "Quarters"),
                            ],
                            onTap: (index) {
                              final tab = ["WEEKS", "MONTHS", "QUARTERS"][index];
                              context.read<OrderCubit>().updateTab(tab);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "${state.groupedData.length} ${context.read<OrderCubit>().selectedTab.toLowerCase()} available",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Expanded Bar Chart
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Y-Axis with Fixed Width
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Container(
                              width: 40, // Fixed width for Y-axis
                              child: BarChart(
                                BarChartData(
                                  minY: 0,
                                  maxY: calculateMaxY(state.groupedData), // Calculate maxY based on data
                                  titlesData: FlTitlesData(
                                    leftTitles: buildLeftTitles(state),
                                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  ),
                                  gridData: FlGridData(show: false),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: const Border(
                                      left: BorderSide(color: Colors.black87, width: 1),
                                    ),
                                  ),
                                  barGroups: [], // No bars for the Y-axis section
                                ),
                              ),
                            ),
                          ),

                          // Scrollable Chart and Bottom Axis
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
          width: calculateDynamicWidth(context, state.groupedData.length),
                                child: BarChart(
                                  BarChartData(
                                    minY: 0,
                                    maxY: calculateMaxY(state.groupedData),
                                    barGroups: buildBarGroups(state.groupedData), // Generate bar groups dynamically
                                    titlesData: buildTitles(state, context),
                                    gridData: FlGridData(show: false),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: const Border(
                                        left: BorderSide(color: Colors.black87, width: 1),
                                        bottom: BorderSide(color: Colors.black87, width: 1),
                                      ),
                                    ),
                                    barTouchData: BarTouchData(enabled: true),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Unexpected error"));
          }
        },
      ),
    );
  }

}