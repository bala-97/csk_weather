import 'package:cks_weather/configurations/environments.dart';

/// A abstract class of app's configurations
abstract class Configuration {
  /// Main constructor for configuration
  const Configuration();

  /// Base Url for network requests
  String get baseUrl => "http://api.weatherapi.com/v1";

  /// Api key for authorization
  /// Not a good idea to store here, should be stored in secure storage or some secured place.
  String get apiKey => "1dcd6a6d575d46f5aba92452210209";

  /// Running env name, defaults to dev
  Environments get environment => Environments.dev;
}
