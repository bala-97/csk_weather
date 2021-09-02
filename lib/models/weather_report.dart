import 'package:hive/hive.dart';

part 'weather_report.g.dart';

/// The formatted weather report shared with view and db
/// TODO Type Id should not be hardcoded like this
@HiveType(typeId: 1)
class WeatherReport extends HiveObject {
  /// Member wise constructor of the object
  WeatherReport(
      {required this.cityName,
      required this.url,
      required this.timeOfReport,
      required this.iconUrl,
      required this.windSpeed,
      required this.uvIndex,
      required this.temperature,
      required this.humidity,
      required this.weatherDescription,
      required this.localTime});

  /// Name of the city at given location
  @HiveField(0)
  final String cityName;

  /// Unique id for every location
  @HiveField(1)
  final String url;

  /// Unique id of the report, when this changed we need to update the UI
  @HiveField(2)
  final double timeOfReport;

  /// Url for weather icon
  @HiveField(3)
  final String? iconUrl;

  /// Wind Speed at given location
  @HiveField(4)
  final double? windSpeed;

  @HiveField(5)
  final double? uvIndex;

  @HiveField(6)
  final double? temperature;

  @HiveField(7)
  final double? humidity;

  @HiveField(8)
  final String? weatherDescription;

  @HiveField(9)
  final String? localTime;
}
