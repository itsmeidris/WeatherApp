import 'package:flutter/material.dart';

//Weather animations
String getWeatherAnimation(String? mainWeatherCondition) {

  if (mainWeatherCondition == null) return 'assets/sunny.json';

  switch (mainWeatherCondition.toLowerCase()) {
    //Defining all weather conditions from OpenWeatherApi.com
    case 'clouds':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/cloudy.json';

    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/rainy.json';

    case 'thunderstorm':
      return 'assets/thunder.json';

    case 'clear':
      return 'assets/sunny.json';
      
    default:
      return 'assets/sunny.json';
  }
}

LinearGradient getBackgroundGradient(bool isDayTime) {
  if (isDayTime) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue, Colors.white],
    );
  } else {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.indigo, Colors.black],
    );
  }
}

Color getTextColor(bool isDayTime) {
  return isDayTime ? Colors.black : Colors.white;
}