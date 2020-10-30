import 'package:flutter/material.dart';
import './Components/searchBar.dart';
import 'Components/weatherCard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './Components/getWeather.dart';
List<String> cities=['austin','Blida'];
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}
class _MyCustomFormState extends State<MyCustomForm> {
  var weatherForecast;
  callback(newWeatherForecast) {
        setState(() {
          weatherForecast = newWeatherForecast;
        });
  }
  saved(city){
    if(!cities.contains(city)){
      setState(() {
        cities.add(city);
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
          color: Colors.white,
        ),
        child:Column(
            children: <Widget>[
              SearchBar(callback),
              weatherForecast!=null?weatherCard(weatherForecast,saved):Text(''),
              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return FutureBuilder(
                      future: getWeather(cities[index]),
                      builder: (context, AsyncSnapshot snapshot){
                        if (!snapshot.hasData) {
                          print(snapshot);
                          return Text('There is an issue');
                      } else {
                        print(snapshot);
                        return Text('snapshot.data[index].toString()');
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