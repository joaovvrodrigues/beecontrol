import '../../services/feed/feed_repository.dart';

class NewsController {
  int indexFilter = 0;
  final Map<String, String> filter = {
    'Apicultura':
        'https://news.google.com/rss/topics/CAAqJggKIiBDQkFTRWdvSkwyMHZNREYyYmpNMUVnVndkQzFDVWlnQVAB?hl=pt-BR&gl=BR&ceid=BR:pt-419',
    'Mel':
        'https://news.google.com/rss/search?q=mel%20abelha&hl=pt-BR&gl=BR&ceid=BR%3Apt-419',
    'Própolis':
        'https://news.google.com/rss/search?q=pr%C3%B3polis&hl=pt-BR&gl=BR&ceid=BR%3Apt-419',
    'Pasto Apícula':
        'https://news.google.com/rss/search?q=Pasto%20Ap%C3%ADcula&hl=pt-BR&gl=BR&ceid=BR%3Apt-419',
    'Abelha Rainha':
        'https://news.google.com/rss/search?q=Abelha%20Rainha%20apicultura&hl=pt-BR&gl=BR&ceid=BR%3Apt-419'
  };

  final FeedRepository _feedRepository = FeedRepository();

  Future getNewFeed(String term) async {
    var feed = await _feedRepository.getFeed(url: filter[term]!);
    return feed;
  }
}
