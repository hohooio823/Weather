import 'package:flutter/material.dart';
import './Components/searchBar.dart';
import 'Components/weatherCard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './Components/getWeather.dart';
List<String> cities=[];
List<String> savedCities=[];
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}
class _MyCustomFormState extends State<MyCustomForm> {
  callback(searchCity) {
        if(!cities.contains(searchCity)){
          setState(() {
            cities=[];
            cities.addAll(savedCities);
            cities.insert(0,searchCity);
          });
        }
  }
  saved(city){
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
      });
      Fluttertoast.showToast(
        msg: "Removed $city from the saved list."
      );
    }
    print(cities);
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
                          return Text('There is an issue');
                      } else {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0,9,0,9),
                          child: weatherCard(snapshot.data,saved),
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