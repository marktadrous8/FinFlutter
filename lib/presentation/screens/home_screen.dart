// lib/presentation/screens/home_screen.dart

import 'package:flutter_metrics/core/app_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MetricsScreen(),
     GraphScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final OrderCubit orderCubit = getIt<OrderCubit>();

    return

      BlocProvider.value(
        value: orderCubit,
        child: BlocConsumer<OrderCubit,OrderState>(
          listener: (context, state) async {
                 },
          builder: (context, state) {
            return       Scaffold(
              appBar: AppBar(
                title: const Text("FinFlutter Insights"),
              ),
              body: _screens[_currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: "Metrics",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.show_chart),
                    label: "Graph",
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            );

          },
        ),
      );
  }


  }

