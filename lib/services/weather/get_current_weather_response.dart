import 'package:cks_weather/models/weather_report.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_weather_response.g.dart';

/// Class that used to get login response.
@JsonSerializable()
class GetCurrentWeatherResponse {
  /// Main constructor with it's params
  GetCurrentWeatherResponse(this.location, this.current);

  /// Converts json to model
  factory GetCurrentWeatherResponse.fromJson(Map<String, dynamic> json) => _$GetCurrentWeatherResponseFromJson(json);

  /// Location info of response
  @JsonKey(name: 'location')
  final Location location;

  /// Current weather info of given location
  @JsonKey(name: 'current')
  final CurrentWeather current;

  /// Converts model to json
  Map<String, dynamic> toJson() => _$GetCurrentWeatherResponseToJson(this);

  /// Convert to weather report model
  WeatherReport get toWeatherReport => WeatherReport(
      cityName: location.name,
      url: location.name,
      timeOfReport: current.last_updated_epoch,
      iconUrl: current.condition.icon,
      windSpeed: current.windSpeed,
      uvIndex: current.uvIndex,
      temperature: current.temperatureInCelsius,
      humidity: current.humidity,
      weatherDescription: current.condition.text,
      localTime: location.localtime);
}

/// Location info of response
@JsonSerializable()
class Location {
  /// Main constructor with it's params
  Location(this.name, this.region, this.localtime);

  /// Converts json to model
  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  /// Name of the location
  @JsonKey(name: 'name')
  final String name;

  /// Region of the location
  @JsonKey(name: 'region')
  final String region;

  /// Time at that location
  @JsonKey(name: 'localtime')
  final String localtime;

  /// Converts model to json
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

/// Current weather info of given location
@JsonSerializable()
class CurrentWeather {
  /// Main constructor with it's params
  CurrentWeather(
    this.last_updated_epoch,
    this.temperatureInCelsius,
    this.windSpeed,
    this.humidity,
    this.feelsLike,
    this.condition,
    this.uvIndex,
  );

  /// Converts json to model
  factory CurrentWeather.fromJson(Map<String, dynamic> json) => _$CurrentWeatherFromJson(json);

  /// Last updated time of weather data
  @JsonKey(name: 'last_updated_epoch')
  final double last_updated_epoch;

  /// Current temperature at given location
  @JsonKey(name: 'temp_c')
  final double temperatureInCelsius;

  /// Speed of wind at given location
  @JsonKey(name: 'wind_kph')
  final double windSpeed;

  /// Humidity at given location
  @JsonKey(name: 'humidity')
  final double humidity;

  /// Condition at given location
  @JsonKey(name: 'condition')
  final Condition condition;

  /// Temperature feels like in celsius at given location
  @JsonKey(name: 'feelslike_c')
  final double feelsLike;

  /// UV index at given location
  @JsonKey(name: 'uv')
  final double uvIndex;

  /// Converts model to json
  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}

@JsonSerializable()
class Condition {
  /// Main constructor with it's params
  Condition(this.text, this.icon);

  /// Converts json to model
  factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);

  /// Weather condition as text
  @JsonKey(name: 'text')
  final String text;

  /// Weather icon url
  @JsonKey(name: 'icon')
  final String icon;

  /// Converts model to json
  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}
