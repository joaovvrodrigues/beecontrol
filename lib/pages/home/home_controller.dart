import 'package:beecontrol/services/feed/feed_repository.dart';
import 'package:beecontrol/services/weather/api_keys.dart';
import 'package:beecontrol/services/weather/weather_api_client.dart';
import 'package:beecontrol/services/weather/weather_repository.dart';

class HomeController {
  WeatherRepository _weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(apiKey: ApiKey.OPEN_WEATHER_MAP));
  FeedRepository _feedRepository = FeedRepository();

  Future getWeather() async {
    var weather = await _weatherRepository.getWeather('Bambuí');
    return weather;
  }

  Future getFeed() async {
    var feed = await _feedRepository.getFeed();
    return feed;
  }
}
