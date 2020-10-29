import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchBar extends StatefulWidget {
  Function(dynamic) callback;
  SearchBar(this.callback);

  @override
  _SearchBarState createState() => _SearchBarState();
}
class _SearchBarState extends State<SearchBar> {
  var city='';
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height:200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.black,
      ),
      alignment: Alignment.center,
      child:Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child:Container(
          height:35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [BoxShadow(
              offset:Offset(0,10),
              blurRadius: 50,
            )]
              ),
              child:TextField(
                      onChanged: (text)=>{
                        getWeather(text)
                        .then((value) =>{
                          if(value!=null){
                            for(var data in value['data']){
                              setState(()=>city=data['city_name']+' '+data['temp'].toString()),
                              widget.callback(data)
                            }
                          }
                        })
                      },
                    )
            )
      )
    );
  }
}

Future getWeather(city) async {
  final response = await http.get('https://api.weatherbit.io/v2.0/current?city=$city&key=922b11ce5fcc43e7af7443f05679c20d');
  return response.body!=''?json.decode(response.body):null;
}