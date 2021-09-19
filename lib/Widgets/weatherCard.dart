import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CardText extends StatelessWidget {
  final String text;
  final double fntSize;
  IconData? icon;

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

Future getWeather(String city) async {
  final response = await http.get(Uri.parse(
      'https://api.weatherbit.io/v2.0/current?city=$city&key=4a4c3a2bd5c941709d3dfffad83a5c04'));
  var value = response.body != '' ? json.decode(response.body) : null;
  if (value != null) {
    return value['data'][0];
  } else {
    return null;
  }
}

class WeatherCard extends StatefulWidget {
  final String city;
  WeatherCard({required this.city});
  @override
  _WeatherCardState createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWeather(widget.city),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            dynamic weatherForecast = snapshot.data;
            return Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardText(
                            text: weatherForecast['city_name'],
                            fntSize: 30,
                          ),
                          CardText(
                            text: weatherForecast['temp'].round().toString() +
                                '°',
                            fntSize: 35,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardText(
                              text: '   ' +
                                  weatherForecast['weather']['description'],
                              icon: weatherIcon(weatherForecast['weather']
                                      ['code']
                                  .toString()))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardText(
                              text: ' ' + weatherForecast['sunrise'].toString(),
                              icon: CupertinoIcons.sunrise),
                          CardText(
                              text: ' ' + weatherForecast['sunset'].toString(),
                              icon: CupertinoIcons.sunset),
                          CardText(
                              text: ' ' +
                                  weatherForecast['wind_spd']
                                      .round()
                                      .toString() +
                                  ' m/s',
                              icon: CupertinoIcons.wind),
                        ],
                      )
                    ],
                  ),
                ));
          } else {
            return Text('State: ${snapshot.connectionState}');
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
