// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Helpers/weatherConditions.dart' as WeatherCondition;
import 'package:weather_app/Models/WeatherModel.dart';
import 'package:weather_app/Services/WeatherService.dart';
import 'package:weather_app/Widgets/CityTextField.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  //Put your own Api key
  final weatherService = WeatherService("ecc967165bf9e44c4377f0b87f82837c");
  WeatherModel? _weather;

  //Textfield controller for retrieving a city name
  final cityFieldController = TextEditingController();
  String cityName = ''.toLowerCase();

  //Fetch the weather
  fetchWeather() async {
    try {
      cityName = await weatherService.getCurrentCity();
    } catch (e) {
      print(e);
    }
    try {
      final weather = await weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }

    if (cityFieldController.text.isNotEmpty) {
      try {
        final weather =
            await weatherService.getWeather(cityFieldController.text);
        setState(() {
          _weather = weather;
        });
      } catch (e) {
        print('Error getting weather for ${cityFieldController.text}: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    Color weatherTextColor =
        WeatherCondition.getTextColor(_weather?.isDayTime ?? true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: WeatherCondition.getBackgroundGradient(
                _weather?.isDayTime ?? true)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CityTextField(
                    myClr: weatherTextColor,
                    myController: cityFieldController,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left :10 ,right: 10 ),
                    child: ElevatedButton(
                    
                      onPressed: () {
                        setState(() {
                          cityName = cityFieldController.text;
                        });
                        fetchWeather();
                        print(cityName);
                      },
                      child:Text(
                        'Search' ,
                        style: GoogleFonts.oxygen(
                          color: weatherTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
                Text(_weather?.cityName ?? "Loading city...",
                      style: GoogleFonts.oxygen(
                          fontSize: 35,
                          color: weatherTextColor,
                          fontWeight: FontWeight.w700)),
                
          
              if (_weather != null)
                Lottie.asset(WeatherCondition.getWeatherAnimation(
                    _weather?.cityCondition)),
              if (_weather != null)
                Text(
                  '${_weather?.cityTemp.round()}°C',
                  style: GoogleFonts.oxygen(
                      fontSize: 35,
                      color: WeatherCondition.getTextColor(
                          _weather?.isDayTime ?? true),
                      fontWeight: FontWeight.w500),
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}
