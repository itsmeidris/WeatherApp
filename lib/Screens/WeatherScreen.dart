// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Helpers/weatherConditions.dart';
import 'package:weather_app/Models/WeatherModel.dart';
import 'package:weather_app/Services/WeatherService.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  //Put your own Api key
  final weatherService = WeatherService("ecc967165bf9e44c4377f0b87f82837c");
  WeatherModel? _weather;

  //Fetch the weather
  fetchWeather() async {
    String cityName = await weatherService.getCurrentCity();

    //Get weather for the current city
    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } 
    catch (e) {
      print(e);
    }
  }

  @override
  void initState(){
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 25,
                  color: Colors.white,
                ),
                Text(
                  _weather?.cityName ?? "Loading city...",
                  style: GoogleFonts.openSans(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.w700
                  )
                ),
              ],
            ),
            Lottie.asset(getWeatherAnimation(_weather?.cityCondition)),
            Text(
              '${_weather?.cityTemp.round()}°C',
              style: GoogleFonts.openSans(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      ),
    );
  }
}
