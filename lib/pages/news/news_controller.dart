
import 'package:beecontrol/services/weather/api_keys.dart';
import 'package:beecontrol/services/weather/weather_api_client.dart';
import 'package:beecontrol/services/weather/weather_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class NewsController {
  ValueNotifier<RssFeed?> feed = ValueNotifier(null);

  WeatherRepository _repository = WeatherRepository(
      weatherApiClient: WeatherApiClient(apiKey: ApiKey.OPEN_WEATHER_MAP));

  Future getWeather() async {
    var weather = await _repository.getWeather('Bambuí');
    return weather;
  }

  Future loadFeed() async {
    try {
      final client = http.Client();
      Uri uri = Uri.parse('https://rss.app/feeds/bGgJT8xfctzZvnyb.xml');
      //'https://news.google.com/rss/topics/CAAqJggKIiBDQkFTRWdvSkwyMHZNREYyYmpNMUVnVndkQzFDVWlnQVAB?hl=pt-BR&gl=BR&ceid=BR:pt-419');
      final response = await client.get(uri);

      feed.value = RssFeed.parse(response.body);
    } catch (e) {
      // handle any exceptions here
    }
  }
}
