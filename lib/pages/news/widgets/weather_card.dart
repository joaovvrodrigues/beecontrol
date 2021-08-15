import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'forecast_horizontal_widget.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({Key? key}) : super(key: key);
  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  bool expanded = false;
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    var weather = context.watch<Weather>();
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 0.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          if (weather.id != 121998)
            setState(() {
              expanded = !expanded;
              opacity = opacity == 0 ? 1 : 0;
            });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          height: expanded ? 280 : 180,
          curve: Curves.ease,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 15, right: 25),
                            child: weather.id != 121998
                                ? Text(
                                    '${weather.temperature.toStringAsFixed(0)}° C',
                                    style: AppTextStyle.boldTitle
                                        .copyWith(fontSize: 40),
                                  )
                                : Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SpinKitFadingCube(
                                          color: AppTheme.dandelion,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          expanded && weather.id != 121998
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Max: ${weather.maxTemperature!.toStringAsFixed(0)}° C        Min: ${weather.minTemperature!.toStringAsFixed(0)}° C',
                                      style: AppTextStyle.boldText,
                                    ),
                                    Text(
                                      'Umidade: ${weather.humidity!.toStringAsFixed(0)}%',
                                      style: AppTextStyle.boldText,
                                    ),
                                  ],
                                )
                              : Text(
                                  'Acompanhe aqui os dados climáticos da sua região',
                                  style: AppTextStyle.boldText,
                                )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25, bottom: 25, right: 25, left: 20),
                        child: Icon(
                          weather.getIconData(),
                          size: 60,
                        )),
                  )
                ],
              ),
              Flexible(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: opacity,
                  child: ForecastHorizontal(
                    weathers: weather.id == 121998 ? [] : weather.forecast!,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
