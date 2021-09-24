import 'core/app_theme.dart';
import 'models/apiary.dart';
import 'models/bee_hive.dart';
import 'models/feed.dart';
import 'models/report.dart';
import 'models/weather.dart';
import 'pages/home/home_page.dart';
import 'utils/constants.dart';
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
  runApp(const MyApp());
}

const uiStyle = SystemUiOverlayStyle(
  statusBarColor: AppTheme.seashell,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
              create: (_) => Apiary(reports: [])),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('pt', 'BR')],
            title: 'Bee Control',
            color: AppTheme.seashell,
            theme: AppTheme.lightTheme,
            home: const HomePage()));
  }
}
