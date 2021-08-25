import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/feed.dart';
import 'package:beecontrol/models/weather.dart';
import 'package:beecontrol/pages/news/widgets/news_card.dart';
import 'package:beecontrol/shared/order_by_widget.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'widgets/weather_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Weather weather =
      Weather(iconCode: '01d', id: 121998, temperature: 0, time: 0);
  Feed feed = Feed();

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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.0),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // CircularButton(
                    //     onTap: () {}, icon: Ionicons.reorder_two_outline),
                    const SizedBox(width: 35, height: 35),
                    Text('Página Inicial', style: AppTextStyle.boldTitle),
                    CircularButton(onTap: () {}, icon: Ionicons.search_outline)
                  ],
                )),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                WeatherCard(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ordernar por: ', style: AppTextStyle.boldText),
                      SizedBox(width: 20),
                      Expanded(child: OrderBy('Apicultura')),
                    ],
                  ),
                ),
                if (feed.feed != null)
                  AnimationLimiter(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
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

/// CUSTOM DROPDOWN
// DropdownButton<String>(
//                             value: dropdownValue,
//                             icon: Container(
//                               height: 25,
//                               width: 25,
//                               margin: EdgeInsets.only(left: 20),
//                               child: Icon(Ionicons.chevron_down_outline),
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
