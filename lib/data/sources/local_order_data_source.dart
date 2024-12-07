// lib/data/sources/local_order_data_source.dart
import 'package:flutter_metrics/core/app_imports.dart';

abstract class LocalOrderDataSource {
  Future<List<OrderModel>> getOrdersFromJson();
}

class LocalOrderDataSourceImpl implements LocalOrderDataSource {
  final String filePath;

  LocalOrderDataSourceImpl({required this.filePath});

  @override
  Future<List<OrderModel>> getOrdersFromJson() async {
    try {
      final jsonString = await rootBundle.loadString(filePath);
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => OrderModel.fromJson(json)).toList();
    } catch (e) {
      throw CacheException('Failed to load orders from JSON');
    }
  }
}
