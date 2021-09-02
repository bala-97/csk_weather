import 'package:cks_weather/services/weather/get_current_weather_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'weather_service.g.dart';

/// Class that responsible to perform network operations
@RestApi()
abstract class WeatherService {
  /// Factory constructor using Retrofit to create service. Uses a Dio instance [dio] for HTTP client.
  ///
  /// [dio] Is required and should not be null. Base URL from [dio] is used by default.
  /// Optionally accepts [baseUrl] to override the base URL of the Dio instance.
  factory WeatherService(Dio dio, {String baseUrl}) = _WeatherService;

  /// Get current weather details,
  /// [key] and [q] is required and [airQualityIndex] is optional positional here which defaults to 'no'
  @GET("/current.json")
  Future<GetCurrentWeatherResponse> getCurrentWeather(@Query('key') String key, @Query('q') String query,
      [@Query('aqi') String airQualityIndex = "no"]);
}
