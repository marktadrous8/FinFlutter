import 'package:flutter_metrics/app.dart';
import 'package:flutter_metrics/core/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await setUpLocators();

  runApp(const MyApp());
}
