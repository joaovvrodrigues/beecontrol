import 'package:flutter/material.dart';

class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) => SplashPage());
      // case '/home':
      //   return MaterialPageRoute(builder: (_) => HomePage(title: arguments.toString()));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
