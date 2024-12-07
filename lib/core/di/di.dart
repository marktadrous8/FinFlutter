
import 'package:flutter_metrics/core/app_imports.dart';

final GetIt getIt = GetIt.instance;
Future<void> setUpLocators() async {
  // Cubits
  getIt.registerFactory(() => OrderCubit(getAllOrders: getIt()));

  // Use Cases
  getIt.registerLazySingleton(() => GetAllOrders(getIt()));

  // Repository
  getIt.registerLazySingleton<OrderRepository>(
        () => OrderRepositoryImpl(localDataSource: getIt()),
  );

  // Data Sources
  getIt.registerLazySingleton<LocalOrderDataSource>(
        () => LocalOrderDataSourceImpl(filePath: 'assets/jsons/orders.json'),
  );
}