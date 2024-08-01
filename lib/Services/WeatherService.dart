// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, constant_identifier_names

import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_app/Models/WeatherModel.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  //Feature for getting the current city
  Future<String> getCurrentCity() async {
    //Get permission from the user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    //Convert the location into a list of placemarks objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //Extract the city name from the first placemarks
    String? city = placemarks[0].locality;
    return city?? 'City not found';
  }
}
