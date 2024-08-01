// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names
import 'package:intl/date_symbol_data_local.dart';

class WeatherModel {
  final String cityName;
  final double cityTemp;
  final String cityCondition;
  final bool isDayTime;

  const WeatherModel(
      {required this.cityName,
      required this.cityTemp,
      required this.cityCondition,
      required this.isDayTime});

  factory WeatherModel.fromJSON(Map<String, dynamic> json) {
    initializeDateFormatting();

    //Get the current time for the given city
    final now = DateTime.now();
    final sunriseTime = DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000);
    final sunsetTime = DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000);

    //Determine if it is daytime or nightime
    final isCityDaytime = now.isAfter(sunriseTime) && now.isBefore(sunsetTime);

    return WeatherModel(
        cityName: json['name'],
        cityTemp: json['main']['temp'].toDouble(),
        cityCondition: json['weather'][0]['main'],
        isDayTime: isCityDaytime
    );
  }

}
