import 'package:flutter/material.dart';

import './SingleCityScreen.dart';
import './AddCitiesScreen.dart';

import 'package:weather/Models/City.dart';

class SavedCitiesScreen extends StatefulWidget {
  @override
  _SavedCitiesScreenState createState() => _SavedCitiesScreenState();
}

class _SavedCitiesScreenState extends State<SavedCitiesScreen> {
  Future<dynamic> showCityScreen(BuildContext context, City city) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => Scaffold(
            appBar: AppBar(),
            body: SingleCityScreen(
                City(name: "NYC", weather: "Freezing", degree: -14)))));
  }

  List<String> cities = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(children: [
        ListView.builder(
            itemCount: cities.length,
            itemBuilder: (ctx, index) {
              return (Container(
                width: double.infinity,
                height: 100,
                child: GestureDetector(
                  child: Card(
                    child: Text(cities[index]),
                  ),
                  onTap: () => showCityScreen(
                      context,
                      City(
                          name: cities[index],
                          weather: "Freezing",
                          degree: -14)),
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
                        .then((data) {
                      setState(() {
                        cities.add(data);
                      });
                      print(cities);
                    });
                  })),
        ),
      ]),
    );
  }
}
