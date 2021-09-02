// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCurrentWeatherResponse _$GetCurrentWeatherResponseFromJson(Map<String, dynamic> json) {
  return GetCurrentWeatherResponse(
    Location.fromJson(json['location'] as Map<String, dynamic>),
    CurrentWeather.fromJson(json['current'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetCurrentWeatherResponseToJson(GetCurrentWeatherResponse instance) => <String, dynamic>{
      'location': instance.location,
      'current': instance.current,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    json['name'] as String,
    json['region'] as String,
    json['localtime'] as String,
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'localtime': instance.localtime,
    };

CurrentWeather _$CurrentWeatherFromJson(Map<String, dynamic> json) {
  return CurrentWeather(
    (json['last_updated_epoch'] as num).toDouble(),
    (json['temp_c'] as num).toDouble(),
    (json['wind_kph'] as num).toDouble(),
    (json['humidity'] as num).toDouble(),
    (json['feelslike_c'] as num).toDouble(),
    Condition.fromJson(json['condition'] as Map<String, dynamic>),
    (json['uv'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CurrentWeatherToJson(CurrentWeather instance) => <String, dynamic>{
      'last_updated_epoch': instance.last_updated_epoch,
      'temp_c': instance.temperatureInCelsius,
      'wind_kph': instance.windSpeed,
      'humidity': instance.humidity,
      'condition': instance.condition,
      'feelslike_c': instance.feelsLike,
      'uv': instance.uvIndex,
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) {
  return Condition(
    json['text'] as String,
    json['icon'] as String,
  );
}

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
      'text': instance.text,
      'icon': instance.icon,
    };
