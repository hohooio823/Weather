import 'package:flutter/material.dart';

import '../Helpers/get_weather.dart';

import '../Models/weather_forecast.dart';
import '../Widgets/weather_card.dart';

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
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          } else if (snapshot.hasData) {
            WeatherForecast weatherForecast = snapshot.data;
            return Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      widget.changeCity != null
                          ? widget.changeCity!(true)
                          : null;
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
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
            return Center(child: Text('There was an error!'));
          }
        });
  }
}
