import 'package:cks_weather/configurations/string_manager.dart';
import 'package:cks_weather/models/weather_report.dart';
import 'package:cks_weather/services/database/hive_database.dart';
import 'package:cks_weather/services/repository/weather_repository.dart';
import 'package:cks_weather/util/injection/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

/// View model for home screen
class HomeVm {
  /// Main constructor with it's params
  HomeVm({WeatherRepository? weatherRepository, StringManager? stringManager, HiveDatabase? hiveDatabase})
      : _weatherRepository = weatherRepository ?? getIt<WeatherRepository>(),
        _stringManager = stringManager ?? getIt<StringManager>(),
        _hiveDatabase = hiveDatabase ?? getIt<HiveDatabase>();

  final WeatherRepository _weatherRepository;
  final StringManager _stringManager;
  final HiveDatabase _hiveDatabase;


  final BehaviorSubject<int> _counterSubject = BehaviorSubject<int>();
  final BehaviorSubject<WeatherReport> _weatherReportSubject = BehaviorSubject<WeatherReport>();

  /// Stream used to update the counter in real time
  Stream<int> get counterStream => _counterSubject.stream;

  /// Stream used to update weather info from cache or internet
  Stream<WeatherReport> get weatherReportStream => _weatherReportSubject.stream;

  /// Default document location
  String get defaultRecordLocation => _hiveDatabase.documentStorageKey;

  /// Helps to increment the counter using streams
  void incrementTheCounter(int value) {
    _counterSubject.sink.add(value);
  }

  /// Load the weather info for fixed location for now
  void loadWeatherReport(String text) {
    _weatherRepository.getWeather(text.isNotEmpty ? text : _stringManager.defaultCityName).listen((event) {
      _weatherReportSubject.sink.add(event);
    });
  }

  /// An integrated listener for weather reports
  ValueListenable<Box<WeatherReport>> get weatherReportListener => _hiveDatabase.getWeatherReportListenable();

  /// Switch to diff modes
  void switchMode() {
    _hiveDatabase.switchMode();
  }

  /// Title of the temperature card
  String get temperatureTitle => _stringManager.temperatureText;
  /// Title of the wind card
  String get windTitle => _stringManager.windText;
  /// Title of the uv index card
  String get uvIndexTitle => _stringManager.indexUvText;
  /// Title of the humidity card
  String get humidityTitle => _stringManager.humidityText;

  /// Hint for text field
  String get enterCityNameHint => _stringManager.enterCityName;
  /// Title of the button, used to load weather data
  String get loadWeatherButtonTitle => _stringManager.loadWeatherData;
}
