import 'dart:convert';
import 'package:beecontrol/models/weather.dart';
import 'package:http/http.dart' as http;

import '../http/http_exception.dart';

/// Wrapper around the open weather map api
/// https://openweathermap.org/current
class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  final apiKey;

  WeatherApiClient({this.apiKey}) : assert(apiKey != null);

  // Future<String> getCityNameFromLocation(
  //     {double latitude, double longitude}) async {
  //   final url =
  //       '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
  //   print('fetching $url');
  //   final res = await this.httpClient.get(url);
  //   if (res.statusCode != 200) {
  //     throw HTTPException(res.statusCode, "unable to fetch weather data");
  //   }
  //   final weatherJson = json.decode(res.body);
  //   return weatherJson['name'];
  // }

  Future<Weather> getWeatherData(String cityName) async {
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey';

    print('fetching $url');
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }

  Future<List<Weather>> getForecast(String cityName) async {
    final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';
    print('fetching $url');
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final forecastJson = json.decode(res.body);
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}
