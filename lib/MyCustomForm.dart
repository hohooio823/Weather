import 'package:flutter/material.dart';
import './Components/searchBar.dart';
import 'Components/weatherCard.dart';

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
        print(newWeatherForecast);
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child:Column(
            children: <Widget>[
              SearchBar(callback),
              weatherCard(weatherForecast!=null?weatherForecast:'')
            ],
          ),
        )
    );
  }
}