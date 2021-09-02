import 'package:cks_weather/configurations/configuration.dart';
import 'package:cks_weather/models/weather_report.dart';
import 'package:cks_weather/services/database/hive_database.dart';
import 'package:cks_weather/services/weather/get_current_weather_response.dart';
import 'package:cks_weather/services/weather/weather_service.dart';
import 'package:cks_weather/util/injection/injection.dart';
import 'package:logger/logger.dart';

/// Repository Delegate is responsible for getting and caching the weather information
class WeatherDelegate {
  /// Main constructor with it's params
  WeatherDelegate(
      {WeatherService? weatherService, Logger? logger, Configuration? configuration, HiveDatabase? hiveDatabase})
      : _weatherService = weatherService ?? getIt<WeatherService>(),
        _logger = logger ?? getIt<Logger>(),
        _configuration = configuration ?? getIt<Configuration>(),
        _hiveDatabase = hiveDatabase ?? getIt<HiveDatabase>();

  final WeatherService _weatherService;
  final Logger _logger;
  final Configuration _configuration;
  final HiveDatabase _hiveDatabase;

  /// Serves the weather data on demand, initially from cache then from server
  /// Also this will update if local cache outdated
  Stream<WeatherReport> getWeather(String cityName) async* {
    _logger.i("Sending getWeather request for : $cityName");

    /// As per request will check anything changed then will save it.
    final WeatherReport? cacheReport = await _hiveDatabase.getWeatherReport();
    if (cacheReport != null) {
      yield cacheReport;
    }
    final GetCurrentWeatherResponse currentWeatherResponse =
        await _weatherService.getCurrentWeather(_configuration.apiKey, cityName);

    final WeatherReport report = currentWeatherResponse.toWeatherReport;

    _hiveDatabase.saveWeatherReport(report);

    /// Check the report time and update
    if (cacheReport == null) {
      _hiveDatabase.saveWeatherReport(report);
    } else {
      if (cacheReport.timeOfReport != report.timeOfReport) _hiveDatabase.saveWeatherReport(report);
    }
    yield report;
  }
}
