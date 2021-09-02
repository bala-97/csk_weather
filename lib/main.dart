import 'package:catcher/catcher.dart';
import 'package:catcher/model/catcher_options.dart';
import 'package:cks_weather/configurations/configuration.dart';
import 'package:cks_weather/configurations/dev/dev_configuration.dart';
import 'package:cks_weather/configurations/string_manager.dart';
import 'package:cks_weather/models/weather_report.dart';
import 'package:cks_weather/screens/home.dart';
import 'package:cks_weather/util/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'configurations/dev/dev_string_manager.dart';

/// Here i assume there is only one build which is dev
/// So i use existing main method
Future<void> main() async {

  await Hive.initFlutter();
  await Hive.openBox<bool>('dark_mode_box');
  Hive.registerAdapter< WeatherReport>(WeatherReportAdapter());
  await Hive.openBox<WeatherReport>('weather_report');

  const config = DevConfiguration();

  /// Leaving to default
  final CatcherOptions options = CatcherOptions(SilentReportMode(), [ConsoleHandler()]);

  Catcher(
    runAppFunction: () => runApp(
      setupApp(
        configuration: config,
        stringManager: const DevStringManager(),
      ),
    ),
    debugConfig: options,
    profileConfig: options,
    releaseConfig: options,
    ensureInitialized: true,
  );
}

/// A function to setup injection and start the app.
Widget setupApp({required Configuration configuration, required StringManager stringManager}) {
  setupInjection(configuration: configuration, stringManager: stringManager);
  return CksWeather();
}
