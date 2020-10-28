import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}
class _MyCustomFormState extends State<MyCustomForm> {
  var city='';
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (text)=>{
                getWeather(text)
                .then((value) =>{
                  if(value!=null){
                    for(var data in value['data']){
                      setState(()=>city=data['city_name']+' '+data['temp'].toString()),
                      print(data['city_name']+' '+data['temp'].toString())
                    }
                  }
                })
              },
            ),
            Text(city)
          ],
        ),
      ),
    );
  }
}

Future getWeather(city) async {
  final response = await http.get('https://api.weatherbit.io/v2.0/current?city=$city&key=922b11ce5fcc43e7af7443f05679c20d');
  return response.body!=''?json.decode(response.body):null;
}