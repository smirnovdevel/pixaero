import 'package:flutter/material.dart';
import 'src/app.dart';
import 'di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //инициализация зависимостей
  await di.init();

  runApp(const App());
}
