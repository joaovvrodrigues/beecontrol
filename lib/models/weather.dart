import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:beecontrol/utils/weather_icon_mapper.dart';
import 'package:beecontrol/utils/converters.dart';

class Weather extends ChangeNotifier {
  int? id;
  int time;
  int? sunrise;
  int? sunset;
  int? humidity;

  String? description;
  String iconCode;
  String? main;
  String? cityName;

  double? windSpeed;

  double temperature;

  List<Weather>? forecast;
  Weather({
    this.id,
    required this.time,
    required this.temperature,
    required this.iconCode,
    this.sunrise,
    this.sunset,
    this.humidity,
    this.description,
    this.main,
    this.cityName,
    this.windSpeed,
  });

  void refresh(Weather _w) {
    id = _w.id;
    time = _w.time;
    description = _w.description;
    iconCode = _w.iconCode;
    main = _w.main;
    cityName = _w.cityName;
    temperature = _w.temperature;
    sunrise = _w.sunrise;
    sunset = _w.sunset;
    humidity = _w.humidity;
    windSpeed = _w.windSpeed;
    forecast = _w.forecast;
    notifyListeners();
  }

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: intToDouble(json['main']['temp']),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      windSpeed: intToDouble(json['wind']['speed']),
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = <Weather>[];
    for (final item in json['list']) {
      weathers.add(Weather(
          time: item['dt'],
          temperature: intToDouble(
            item['temp']['day'],
          ),
          iconCode: item['weather'][0]['icon']));
    }
    return weathers;
  }

  IconData getIconData() {
    switch (this.iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'sunrise': sunrise,
      'sunset': sunset,
      'humidity': humidity,
      'description': description,
      'iconCode': iconCode,
      'main': main,
      'cityName': cityName,
      'windSpeed': windSpeed,
      'temperature': temperature,
      'forecast': forecast?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
