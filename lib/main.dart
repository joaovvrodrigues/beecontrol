import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/bee_hive.dart';
import 'package:beecontrol/models/feed.dart';
import 'package:beecontrol/models/report.dart';
import 'package:beecontrol/models/weather.dart';
import 'package:beecontrol/pages/home/home_page.dart';
import 'package:beecontrol/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ApiaryAdapter());
  Hive.registerAdapter(BeeHiveAdapter());
  Hive.registerAdapter(ReportAdapter());
  await Hive.openBox<Apiary>(CONSTANTS.box);
  runApp(MyApp());
}

const uiStyle = SystemUiOverlayStyle(
  statusBarColor: AppTheme.seashell,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(uiStyle);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Weather>(
              create: (_) => Weather(
                  iconCode: '01d', id: 121998, temperature: 0, time: 0)),
          ChangeNotifierProvider<Feed>(
            create: (_) => Feed(),
          ),
          ChangeNotifierProvider<Apiary>(
              create: (_) => Apiary(hives: [], reports: [])),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('pt', 'BR')],
            title: 'Bee Control',
            color: AppTheme.seashell,
            theme: AppTheme.lightTheme,
            home: HomePage()));
  }
}
