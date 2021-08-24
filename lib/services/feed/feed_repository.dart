import 'package:beecontrol/services/http/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class FeedRepository {
  Future getFeed() async {
    final client = http.Client();
    Uri uri = Uri.parse(//'https://rss.app/feeds/QbeTGBmSCRd9yKVS.xml');
        'https://news.google.com/rss/topics/CAAqJggKIiBDQkFTRWdvSkwyMHZNREYyYmpNMUVnVndkQzFDVWlnQVAB?hl=pt-BR&gl=BR&ceid=BR:pt-419');

    final response = await client.get(uri);
    if (response.statusCode != 200) {
      throw HTTPException(response.statusCode, "unable to fetch feed data");
    }
    return RssFeed.parse(response.body);
  }
}
