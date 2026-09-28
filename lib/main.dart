import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'core/storage/hive_boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final progressBox = await Hive.openBox<Map<dynamic, dynamic>>(
    HiveBoxes.progress,
  );
  final sharedPreferences = await SharedPreferences.getInstance();

  await setupDependencyInjection(
    progressBox: progressBox,
    sharedPreferences: sharedPreferences,
  );

  runApp(const ThaheenApp());
}
