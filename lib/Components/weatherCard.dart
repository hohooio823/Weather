import 'package:flutter/material.dart';
import './CardText.dart';

class weatherCard extends StatefulWidget {
  dynamic weatherForecast;
  weatherCard(this.weatherForecast);
  @override
  _weatherCardState createState() => _weatherCardState();
}
class _weatherCardState extends State<weatherCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(padding: EdgeInsets.fromLTRB(20,30,25,45),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(25,10,25,20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children:[
                    CardText(widget.weatherForecast['city_name']),
                    CardText(widget.weatherForecast['temp'].round().toString()),
                  ],),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                    CardText(widget.weatherForecast['weather']['description'])
                  ],),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                    CardText(widget.weatherForecast['sunrise'].toString()),
                    CardText(widget.weatherForecast['sunset'].toString()),
                    CardText(widget.weatherForecast['wind_spd'].toString()),
                  ],)
              ],
            ),
          ),
        )
    )
  );
  }
}
//widget.weatherForecast['city_name']+ ' '+widget.weatherForecast['weather']['description']+ ' '+widget.weatherForecast['temp'].toString()+ ' '+widget.weatherForecast['sunrise'].toString()+ ' '+widget.weatherForecast['sunset'].toString()+ ' '+widget.weatherForecast['temp'].toString()+ ' '+widget.weatherForecast['sunrise'].toString()+ ' '+widget.weatherForecast['wind_spd'].toString()