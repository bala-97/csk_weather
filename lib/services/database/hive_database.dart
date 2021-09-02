import 'package:cks_weather/models/weather_report.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

/// Hive Database for storing weather report
/// Implemented in simple way, can be extended in more generic way
class HiveDatabase {
  final String _reportBoxName = "weather_report";
  final String _darkModeBox = "dark_mode_box";

  /// Since we store single record for now, we use fixed key to find document
  final String documentStorageKey = "WE_STORE_ONE_REPORT_FOR_NOW";

  /// Initialize the hive database
  Future<void> initHive() async {
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter<WeatherReport>(WeatherReportAdapter());
  }

  /// Save weather report
  Future<void> saveWeatherReport(WeatherReport report) async {
    final box = await Hive.openBox<WeatherReport>(_reportBoxName);
    await box.put(documentStorageKey, report);
  }

  /// Fetch everything from local db
  Future<WeatherReport?> getWeatherReport() async {
    final box = await Hive.openBox<WeatherReport>(_reportBoxName);
    return box.get(documentStorageKey);
  }

  /// Fetch everything from local db
  Future<void> switchMode() async {
    final box = await Hive.openBox<bool>(_darkModeBox);
    final status = box.get("darkMode") ?? false;
    box.put('darkMode', !status);
  }

  /// Dark mode listener that attached to UI directly to fetch updates
  ValueListenable<Box<bool>> getDarkModeListenable() {
    return Hive.box<bool>(_darkModeBox).listenable();
  }

  /// Weather report listener that attached to UI directly to fetch updates
  ValueListenable<Box<WeatherReport>> getWeatherReportListenable() {
    return Hive.box<WeatherReport>(_reportBoxName).listenable();
  }
}
