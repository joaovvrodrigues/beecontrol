import 'package:flutter/foundation.dart';
import 'package:webfeed/webfeed.dart';

class Feed extends ChangeNotifier {
  RssFeed? feed;

  void refresh(RssFeed? newFeed) {
    feed = newFeed;
    notifyListeners();
  }
}
