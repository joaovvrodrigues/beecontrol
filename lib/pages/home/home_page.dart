import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/feed.dart';
import 'package:beecontrol/models/weather.dart';
import 'package:beecontrol/pages/home/home_controller.dart';
// ignore: unused_import
import 'package:beecontrol/pages/news/news_controller.dart';
import 'package:beecontrol/pages/news/news_page.dart';
import 'package:beecontrol/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Ionicons.newspaper_outline,
    Icons.inventory,
    Icons.brightness_6,
    Icons.brightness_7,
  ];

  final pages = <Widget>[
    NewsPage(),
    RegisterPage(),
    RegisterPage(),
    RegisterPage()
  ];

  HomeController controller = HomeController();
  Weather weather =
      Weather(iconCode: '01d', id: 121998, temperature: 0, time: 0);
  Feed feed = Feed();

  void loadWeather() async {
    var _w = await controller.getWeather();
    weather.refresh(_w);
  }

  void loadFeed() async {
    var _f = await controller.getFeed();
    feed.refresh(_f);
  }

  @override
  void initState() {
    super.initState();
    loadWeather();
    loadFeed();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    weather = context.read<Weather>();
    feed = context.read<Feed>();
    return Scaffold(
      extendBody: true,
      body: pages[_bottomNavIndex],
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: AppTheme.dandelion,
          child: Icon(
            Icons.add_rounded,
            color: AppTheme.eclipse,
          ),
          onPressed: () {
            _animationController.reset();
            _animationController.forward();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? AppTheme.dandelion : Colors.grey[400];
          return Icon(
            iconList[index],
            size: 24,
            color: color,
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        splashColor: AppTheme.dandelion,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.smoothEdge,
        gapLocation: GapLocation.center,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
