import 'package:flutter/material.dart';
import './CardText.dart';
import 'package:flutter/cupertino.dart';

class weatherCard extends StatefulWidget {
  dynamic weatherForecast;
  Function(dynamic) saved;
  weatherCard(this.weatherForecast,this.saved);
  @override
  _weatherCardState createState() => _weatherCardState();
}
class _weatherCardState extends State<weatherCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12,0,12,0),
      child:InkWell(
        onDoubleTap:(){widget.saved(widget.weatherForecast['city_name']);},
        child:Container(
            height:200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0,10,0,20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:[
                        CardText(widget.weatherForecast['city_name'],30),
                        CardText(widget.weatherForecast['temp'].round().toString()+'°',35),
                    ],),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                      CardText('   '+widget.weatherForecast['weather']['description'],null,weatherIcon(widget.weatherForecast['weather']['code'].toString()))
                    ],),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                      CardText(' '+widget.weatherForecast['sunrise'].toString(),null,CupertinoIcons.sunrise),
                      CardText(' '+widget.weatherForecast['sunset'].toString(),null,CupertinoIcons.sunset),
                      CardText(' '+widget.weatherForecast['wind_spd'].round().toString()+' m/s',null,CupertinoIcons.wind),
                    ],)
                ],
              ),
            ),
          )
      )
    );
  }
}
IconData weatherIcon (Weather){
  switch(Weather[0]) { 
    case '2': { 
      return CupertinoIcons.cloud_bolt_rain; 
    } 
    break; 

    case '3': { 
      return CupertinoIcons.cloud_drizzle; 
    } 
    break; 

    case '5': { 
      return CupertinoIcons.cloud_rain; 
    } 
    break; 

    case '6': { 
      return CupertinoIcons.cloud_snow; 
    } 
    break; 

    case '7': { 
      return CupertinoIcons.smoke; 
    } 
    break; 

    case '8': {
      if(Weather[2]=='0'){
        return CupertinoIcons.sun_max;
      }else if(Weather[2]=='4'){
        return CupertinoIcons.cloud;
      }else{
        return CupertinoIcons.cloud_sun;
      }
    } 
    break;

    default: { 
      return CupertinoIcons.sun_max;  
    }
    break; 
  } 
}
//widget.weatherForecast['city_name']+ ' '+widget.weatherForecast['weather']['description']+ ' '+widget.weatherForecast['temp'].toString()+ ' '+widget.weatherForecast['sunrise'].toString()+ ' '+widget.weatherForecast['sunset'].toString()+ ' '+widget.weatherForecast['temp'].toString()+ ' '+widget.weatherForecast['sunrise'].toString()+ ' '+widget.weatherForecast['wind_spd'].toString()