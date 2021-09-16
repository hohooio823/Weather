
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future getWeather(city) async {
  final response = await http.get('https://api.weatherbit.io/v2.0/current?city=$city&key=4a4c3a2bd5c941709d3dfffad83a5c04');
  var value = response.body!=''?json.decode(response.body):null;
  if(value!=null){
      return value['data'][0];
  }else{
    return null;
  }
}