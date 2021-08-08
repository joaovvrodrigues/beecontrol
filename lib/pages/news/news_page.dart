import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/models/weather.dart';
import 'package:beecontrol/pages/news/news_controller.dart';
import 'package:beecontrol/pages/news/widgets/news_card.dart';
import 'package:beecontrol/pages/news/widgets/order_by_widget.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:webfeed/domain/rss_feed.dart';
import 'widgets/weather_card.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  NewsController controller = NewsController();
  Weather weather =
      Weather(iconCode: '01d', id: 121998, temperature: 0, time: 0);

  void loadWeather() async {
    var _w = await controller.getWeather();
    weather.refresh(_w);
  }

  @override
  void initState() {
    controller.loadFeed();
    loadWeather();
    timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    weather = context.read<Weather>();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularButton(onTap: () {}, icon: Icons.menu_rounded),
                  Text('Página Inicial', style: AppTextStyle.boldTitle),
                  CircularButton(onTap: () {}, icon: Icons.search_rounded)
                ],
              )),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            WeatherCard(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ordernar por: ', style: AppTextStyle.boldText),
                  OrderBy('Apicultura'),
                  OrderBy('Recentes'),
                ],
              ),
            ),
            ValueListenableBuilder<RssFeed?>(
                valueListenable: controller.feed,
                builder: (_, feed, __) {
                  if (feed != null)
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: feed.items!.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            image: feed
                                    .items![index].media!.contents!.isNotEmpty
                                ? feed.items![index].media!.contents!.first.url!
                                : 'https://www.infoescola.com/wp-content/uploads/2008/07/apicultura_1132051784.jpg',
                            url: feed.items![index].link!,
                            title: feed.items![index].title!,
                            date: timeago.format(feed.items![index].pubDate!,
                                locale: 'pt_br'),
                          );
                        });
                  else
                    return Center(child: CircularProgressIndicator());
                })
            // NewsCard(
            //   image: 'https://i.ytimg.com/vi/j5fEWJIJJKc/maxresdefault.jpg',
            //   title: 'Curso de Apicultura Migratória',
            //   date: '5h 23 minutos atrás',
            // ),
            // NewsCard(
            //   image:
            //       'https://www.sitiopema.com.br/wp-content/uploads/2020/09/apicultura.jpg',
            //   title: 'Melhores práticas de manejo',
            //   date: '8h 30 minutos atrás',
            // )
          ],
        ),
      ),
    );
  }
}





/// CUSTOM DROPDOWN
// DropdownButton<String>(
//                             value: dropdownValue,
//                             icon: Container(
//                               height: 25,
//                               width: 25,
//                               margin: EdgeInsets.only(left: 20),
//                               child: Icon(Icons.arrow_drop_down_rounded),
//                               decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.2),
//                                     blurRadius: 13,
//                                     offset: Offset(
//                                         0, 5), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             iconSize: 30,
//                             elevation: 16,
//                             style: AppTextStyle.boldText,
//                             underline: SizedBox(),
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 dropdownValue = newValue!;
//                               });
//                             },
//                             items: <String>['Apicultura', 'Data']
//                                 .map<DropdownMenuItem<String>>((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList(),
//                           )