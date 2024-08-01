// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

class WeatherModel {
  final String cityName;
  final double cityTemp;
  final String cityCondition;

  const WeatherModel(
      {required this.cityName,
      required this.cityTemp,
      required this.cityCondition});

  factory WeatherModel.fromJSON(Map<String ,dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      cityTemp: json['main']['temp'].toDouble(),
      cityCondition: json['weather'][0]['main'],   
    );
  }
}
