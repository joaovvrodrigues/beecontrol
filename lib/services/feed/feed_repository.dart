import 'package:beecontrol/services/http/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

const String apiculture =
    'https://news.google.com/rss/topics/CAAqJggKIiBDQkFTRWdvSkwyMHZNREYyYmpNMUVnVndkQzFDVWlnQVAB?hl=pt-BR&gl=BR&ceid=BR:pt-419';

class FeedRepository {
  Future getFeed({String url = apiculture}) async {
    final client = http.Client();
    Uri uri = Uri.parse(url);

    final response = await client.get(uri);
    if (response.statusCode != 200) {
      throw HTTPException(response.statusCode, "unable to fetch feed data");
    }
    return RssFeed.parse(response.body);
  }
}
