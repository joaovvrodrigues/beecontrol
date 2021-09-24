import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color sunset = Color(0xFFF65B4E);
  static const Color monalisa = Color(0xFFFF9A9A);
  static const Color twilight = Color(0xFF29319F);
  static const Color seashell = Color(0xFFFFF3E9);
  static const Color morning = Color(0xFFFFBA7C);
  static const Color fog = Color(0xFFFFDEEF);
  static const Color eclipse = Color(0xFF573353);
  static const Color dandelion = Color(0xFFFFDE5F);

  static const Map<int, Color> colorCodes = {
    50: Color.fromRGBO(255, 222, 95, .1),
    100: Color.fromRGBO(255, 222, 95, .2),
    200: Color.fromRGBO(255, 222, 95, .3),
    300: Color.fromRGBO(255, 222, 95, .4),
    400: Color.fromRGBO(255, 222, 95, .5),
    500: Color.fromRGBO(255, 222, 95, .6),
    600: Color.fromRGBO(255, 222, 95, .7),
    700: Color.fromRGBO(255, 222, 95, .8),
    800: Color.fromRGBO(255, 222, 95, .9),
    900: Color.fromRGBO(255, 222, 95, 1),
  };

  static const MaterialColor dandelionMaterial =
      MaterialColor(0xFFFFDE5F, colorCodes);

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: seashell,
      scaffoldBackgroundColor: seashell,
      // bottomAppBarColor: MaterialColor(0xFFFFDE5F, colorCodes),
      backgroundColor: seashell,
      fontFamily: 'Manrope',
      primaryColorBrightness: Brightness.light,
      canvasColor: seashell,
      splashColor: dandelionMaterial.shade300,
      errorColor: monalisa,
      bottomAppBarColor: Colors.white,
      cardColor: Colors.white,
      dividerColor: seashell,
      focusColor: morning,
      buttonTheme: ButtonThemeData(
        colorScheme: ColorScheme.fromSwatch(),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder()
          }), colorScheme: ColorScheme.fromSwatch(primarySwatch: dandelionMaterial).copyWith(secondary: dandelion));

  InputDecoration inputDecoration(IconData icon) {
    return InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefix: Icon(icon, color: eclipse),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ));
  }

  // static ThemeData darkTheme = ThemeData(
  //     scaffoldBackgroundColor: const Color(0xFF212121),
  //     primarySwatch: Colors.yellow,
  //     primaryColor: Colors.black,
  //     brightness: Brightness.dark,
  //     backgroundColor: const Color(0xFF212121),
  //     accentColor: AppTheme.appColor,
  //     accentIconTheme: IconThemeData(color: Colors.black),
  //     dividerColor: Colors.black12,
  //     pageTransitionsTheme: const PageTransitionsTheme(
  //         builders: <TargetPlatform, PageTransitionsBuilder>{
  //           TargetPlatform.android: ZoomPageTransitionsBuilder()
  //         }));

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: eclipse,
      elevation: 0,
      primary: dandelion,
      textStyle:
          const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: eclipse),
      minimumSize: const Size(400, 60),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ));

  // static ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  //   elevation: 0,
  //   primary: AppTheme.appColor,
  //   backgroundColor: Colors.black,
  //   textStyle: TextStyle(
  //       fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
  //   minimumSize: Size(400, 60),
  //   padding: EdgeInsets.symmetric(horizontal: 40),
  //   side: BorderSide(color: AppTheme.appColor, width: 3),
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(12)),
  //   ),
  // );
}
