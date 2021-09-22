import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/WeatherForecast.dart';

Future getWeather(String city) async {
  final response = await http.get(Uri.parse(
      'https://api.weatherbit.io/v2.0/current?city=$city&key=4a4c3a2bd5c941709d3dfffad83a5c04'));
  var value = response.body != '' ? json.decode(response.body) : null;
  if (value != null) {
    final data = value['data'][0];
    WeatherForecast weatherForecast = WeatherForecast(
        name: data['city_name'],
        weather: data['weather']['description'],
        temperature: data['temp'].round(),
        sunrise: data['sunrise'],
        sunset: data['sunset'],
        windSpeed: data['wind_spd'].round(),
        code: data['weather']['code'].toString());
    return weatherForecast;
  } else {
    return null;
  }
}
