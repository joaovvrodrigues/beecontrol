// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

// 🌎 Project imports:
import '../../core/app_text_style.dart';
import '../../core/app_theme.dart';
import '../../models/feed.dart';
import '../../models/weather.dart';
import '../apiary_report/widgets/order_by.dart';
import 'news_controller.dart';
import 'widgets/news_card.dart';
import 'widgets/weather_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Weather weather =
      Weather(iconCode: '01d', id: 121998, temperature: 0, time: 0);
  Feed feed = Feed();

  NewsController controller = NewsController();

  @override
  void initState() {
    timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weather = context.read<Weather>();
    feed = context.watch<Feed>();
    return SafeArea(
      child: Scaffold(
          appBar: null,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 16),
                  child: Center(
                      child: Text('Página Inicial',
                          style: AppTextStyle.boldTitle)),
                ),
                const WeatherCard(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: OrderBy(
                      title: 'Pesquisar por: ',
                      orderByList: controller.filter.keys.toList(),
                      orderBy: controller.indexFilter,
                      onSaved: (value) async {
                        feed.refresh(await controller.getNewFeed(value!));
                      }),
                ),
                if (feed.feed != null)
                  AnimationLimiter(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: feed.feed!.items!.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 400),
                                delay: const Duration(milliseconds: 150),
                                child: SlideAnimation(
                                    child: FadeInAnimation(
                                        child: NewsCard(
                                  image: feed.feed!.items![index].media!
                                          .contents!.isNotEmpty
                                      ? feed.feed!.items![index].media!
                                          .contents!.first.url!
                                      : 'https://www.infoescola.com/wp-content/uploads/2008/07/apicultura_1132051784.jpg',
                                  url: feed.feed!.items![index].link!,
                                  title: feed.feed!.items![index].title!,
                                  date: timeago.format(
                                      feed.feed!.items![index].pubDate!,
                                      locale: 'pt_br'),
                                ))));
                          }))
                else
                  const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: SpinKitFadingCube(
                      color: AppTheme.dandelion,
                      size: 40,
                    ),
                  )
              ],
            ),
          )),
    );
  }
}
