import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import './SingleCityScreen.dart';
import './AddCitiesScreen.dart';

import 'package:weather/Models/City.dart';
import '../Widgets/WeatherCard.dart';

class SavedCitiesScreen extends StatefulWidget {
  @override
  _SavedCitiesScreenState createState() => _SavedCitiesScreenState();
}

class _SavedCitiesScreenState extends State<SavedCitiesScreen> {
  _updateCityPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cities', json.encode(cities));
  }

  Future<dynamic> _showCityScreen(BuildContext context, String city) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            Scaffold(appBar: AppBar(), body: SingleCityScreen(city))));
  }

  List cities = [];
  Future? _future;
  Future fetchCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? citiesEncoded = prefs.getString('cities');
    cities = jsonDecode(citiesEncoded!);
    return cities;
  }

  @override
  Widget build(BuildContext context) {
    _future = fetchCities();
    void shouldReload() {
      setState(() {
        _future = fetchCities();
      });
    }

    void citiesAdd(city) {
      cities.add(city);
      _updateCityPreference();
      shouldReload();
    }

    void citiesRemove(city) {
      cities.remove(city);
      _updateCityPreference();
      shouldReload();
    }

    print(cities);
    return FutureBuilder(
        future: _future,
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              child: Stack(children: [
                ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      return (Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 100,
                        child: GestureDetector(
                          child: WeatherCard(
                            city: snapshot.data[index],
                          ),
                          onLongPress: () => citiesRemove(snapshot.data[index]),
                          onTap: () =>
                              _showCityScreen(context, snapshot.data[index]),
                        ),
                      ));
                    }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FloatingActionButton(
                          child: Text('+'),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (ctx) => Scaffold(
                                          appBar: AppBar(),
                                          body: AddCitiesScreen(),
                                        )))
                                .then((city) => citiesAdd(city));
                          })),
                ),
              ]),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text("${snapshot.connectionState}");
          }
        });
  }
}
