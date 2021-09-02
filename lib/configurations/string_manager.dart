/// An class contains all the strings used in app.
class StringManager {
  /// Main constructor of string manager
  const StringManager();

  /// Name of the app
  String get appName => "Cks Weather";

  /// Common text
  String get temperatureText => "Temperature";

  /// Common text
  String get windText => "Wind";

  /// Common text
  String get indexUvText => "Index UV";

  /// Common text
  String get humidityText => "Humidity";

  /// Hint of the text field
  String get enterCityName => "Enter city name";

  /// Load weather button text
  String get loadWeatherData => "Load weather data";

  /// Default city name used when first installation
  String get defaultCityName => "koyamuttur-tamil-nadu-india";
}
