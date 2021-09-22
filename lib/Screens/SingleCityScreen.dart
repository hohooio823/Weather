import 'package:flutter/material.dart';

import '../Helpers/getWeather.dart';

import '../Models/WeatherForecast.dart';
import '../Widgets/WeatherCard.dart';

class SingleCityScreen extends StatefulWidget {
  final String cityName;
  final Function? changeCity;

  SingleCityScreen({required this.cityName, this.changeCity});

  @override
  _SingleCityScreenState createState() => _SingleCityScreenState();
}

class _SingleCityScreenState extends State<SingleCityScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWeather(widget.cityName),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            WeatherForecast weatherForecast = snapshot.data;
            return Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.changeCity != null
                          ? widget.changeCity!(true)
                          : null;
                    },
                    child: Container(
                      height: 400,
                      child: WeatherCard(
                        city: weatherForecast.name,
                        isSingleCityScreen: true,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('There was an error!');
          }
        });
  }
}
