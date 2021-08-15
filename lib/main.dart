import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/feed.dart';
import 'package:beecontrol/models/weather.dart';
import 'package:beecontrol/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

const uiStyle = SystemUiOverlayStyle(
  statusBarColor: AppTheme.seashell,
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
          )
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
          theme: AppTheme.lightTheme,
          home: HomePage(),
        ));
  }
}
