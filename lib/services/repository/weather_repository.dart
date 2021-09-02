import 'package:cks_weather/models/weather_report.dart';
import 'package:cks_weather/services/repository/weather_delegate.dart';
import 'package:cks_weather/util/injection/injection.dart';

/// This repository that manages the communication with server
/// Use delegation for most of it's actions
class WeatherRepository implements WeatherDelegate {
  /// Main constructor with it's params
  WeatherRepository({WeatherDelegate? weatherDelegate})
      : _weatherDelegate = weatherDelegate ?? getIt<WeatherDelegate>();

  final WeatherDelegate _weatherDelegate;

  @override
  Stream<WeatherReport> getWeather(String cityName) {
    return _weatherDelegate.getWeather(cityName);
  }
}
