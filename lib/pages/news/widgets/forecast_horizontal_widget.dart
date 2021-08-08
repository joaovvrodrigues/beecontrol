import 'package:beecontrol/models/weather.dart';
import 'package:beecontrol/pages/news/widgets/value_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Renders a horizontal scrolling list of weather conditions
/// Used to show forecast
/// Shows DateTime, Weather Condition icon and Temperature
class ForecastHorizontal extends StatelessWidget {
  const ForecastHorizontal({
    Key? key,
    required this.weathers,
  }) : super(key: key);

  final List<Weather> weathers;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: this.weathers.length,
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = this.weathers[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: ValueTile(
              DateFormat('E, H:mm', 'pt_BR').format(
                  DateTime.fromMillisecondsSinceEpoch(item.time * 1000)),
              '${item.temperature.toStringAsFixed(0)} °C',
              iconData: item.getIconData(),
            )),
          );
        },
      ),
    );
  }
}
