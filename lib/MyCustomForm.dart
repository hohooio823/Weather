import 'package:flutter/material.dart';
import './Components/searchBar.dart';

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}
class _MyCustomFormState extends State<MyCustomForm> {
  var weatherForecast;

  callback(newWeatherForecast) {
        setState(() {
          weatherForecast = newWeatherForecast;
        });
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            children: <Widget>[
              SearchBar(callback),
              Text(weatherForecast!=null?weatherForecast['temp'].toString():'')
            ],
        ),
    );
  }
}