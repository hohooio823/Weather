import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/searchBar.dart';
import '../Widgets/weatherCard.dart';
import '../Widgets/getWeather.dart';


List<String> cities=[];
List<String> savedCities=[];
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState(){
    super.initState();
    _prefs.then((SharedPreferences prefs) {
        setState((){
          savedCities = prefs.getStringList('savedCities');
          cities.addAll(savedCities);
        });
      });
  }
  callback(searchCity) {
        if(!cities.contains(searchCity)){
          setState(() {
            cities=[];
            cities.addAll(savedCities);
            cities.insert(0,searchCity);
          });
        }
  }
  saved(city) async {
    final SharedPreferences prefs = await _prefs;
    if(!cities.contains(city)){
      setState(() {
        cities.add(city);
        savedCities.add(city);
      });
      Fluttertoast.showToast(
        msg: "Added $city to the saved list."
      );
    }else{
      setState(() {
        cities.remove(city);
        savedCities.remove(city);
      });
      Fluttertoast.showToast(
        msg: "Removed $city from the saved list."
      );
    }
    setState(() {
      prefs.setStringList("savedCities", savedCities);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color:Color(0xff10103a),
        ),
        child:Column(
            children: <Widget>[
              SearchBar(callback),
             Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  padding: EdgeInsets.fromLTRB(12,0,12,0),
                  itemBuilder: (BuildContext ctxt, int index) {
                    return FutureBuilder(
                      future: getWeather(cities[index]),
                      builder: (context, AsyncSnapshot snapshot){
                        if (!snapshot.hasData) {
                          print(snapshot);
                          return Text('');
                      } else {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0,9,0,9),
                          child: WeatherCard(snapshot.data,saved),
                        );
                      }
                      }
                    );
                  }
              ))
            ],
          ),
        )
    );
  }
}