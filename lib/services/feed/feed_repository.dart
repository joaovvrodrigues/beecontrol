import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class FeedRepository {
  Future getFeed() async {
    try {
      final client = http.Client();
      Uri uri = Uri.parse('https://rss.app/feeds/bGgJT8xfctzZvnyb.xml');
      //'https://news.google.com/rss/topics/CAAqJggKIiBDQkFTRWdvSkwyMHZNREYyYmpNMUVnVndkQzFDVWlnQVAB?hl=pt-BR&gl=BR&ceid=BR:pt-419');
      final response = await client.get(uri);

      return RssFeed.parse(response.body);
    } catch (e) {
      // handle any exceptions here
    }
  }
}
