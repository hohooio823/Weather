import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../Models/weather_forecast.dart';

import '../Helpers/get_weather.dart';

class CardText extends StatelessWidget {
  final String text;
  final double fntSize;
  final IconData? icon;

  CardText({required this.text, this.fntSize = 14, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(icon),
      Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.8,
          fontSize: fntSize,
        ),
      ),
    ]);
  }
}

class WeatherCard extends StatefulWidget {
  final String city;
  final bool isSingleCityScreen;
  WeatherCard({
    required this.city,
    this.isSingleCityScreen = false,
  });
  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  dynamic isSingleCityScreenHandler =
      (widget, WeatherForecast weatherForecast) {
    if (widget.isSingleCityScreen) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardText(text: DateFormat('EEEE').format(DateTime.now()).toString())
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardText(
                text: ' ${weatherForecast.weather}',
                icon: weatherIcon(weatherForecast.code),
                fntSize: 17.5,
              )
            ],
          ),
        )
      ];
    } else {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardText(
              text: ' ${weatherForecast.weather}',
              icon: weatherIcon(weatherForecast.code),
            )
          ],
        )
      ];
    }
  };
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWeather(widget.city),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          } else if (snapshot.hasData) {
            WeatherForecast weatherForecast = snapshot.data;
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardText(
                            text: weatherForecast.name,
                            fntSize: 30,
                          ),
                          CardText(
                            text: '${weatherForecast.temperature}°',
                            fntSize: 27.5,
                          ),
                        ],
                      ),
                      ...isSingleCityScreenHandler(widget, weatherForecast),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardText(
                              text: ' ${weatherForecast.sunrise}',
                              icon: CupertinoIcons.sunrise),
                          CardText(
                              text: ' ${weatherForecast.sunset}',
                              icon: CupertinoIcons.sunset),
                          CardText(
                              text: ' ${weatherForecast.windSpeed} m/h',
                              icon: CupertinoIcons.wind),
                        ],
                      )
                    ],
                  ),
                ));
          } else {
            return Center(child: Text('There was an error!'));
          }
        });
  }
}

IconData weatherIcon(weather) {
  switch (weather[0]) {
    case '2':
      {
        return CupertinoIcons.cloud_bolt_rain;
      }

    case '3':
      {
        return CupertinoIcons.cloud_drizzle;
      }

    case '5':
      {
        return CupertinoIcons.cloud_rain;
      }

    case '6':
      {
        return CupertinoIcons.cloud_snow;
      }

    case '7':
      {
        return CupertinoIcons.smoke;
      }

    case '8':
      {
        if (weather[2] == '0') {
          return CupertinoIcons.sun_max;
        } else if (weather[2] == '4') {
          return CupertinoIcons.cloud;
        } else {
          return CupertinoIcons.cloud_sun;
        }
      }

    default:
      {
        return CupertinoIcons.sun_max;
      }
  }
}
