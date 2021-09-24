// 🌎 Project imports:
import '../../models/weather.dart';
import 'weather_api_client.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;
  WeatherRepository({required this.weatherApiClient});

  Future<Weather> getWeather(String cityName,
      {double? latitude, double? longitude}) async {
    // if (cityName == null) {
    //   cityName = await weatherApiClient.getCityNameFromLocation(
    //       latitude: latitude, longitude: longitude);
    // }
    var weather = await weatherApiClient.getWeatherData(cityName);
    var weathers = await weatherApiClient.getForecast(cityName);
    weather.forecast = weathers;
    return weather;
  }
}
