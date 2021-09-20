import 'package:flutter/material.dart';

import '../Models/City.dart';

class SingleCityScreen extends StatelessWidget {
  String cityName;

  SingleCityScreen(this.cityName);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(cityName)
          /*Text(city.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(city.degree.toString()), Text(city.weather)],
          )*/
        ],
      ),
    );
  }
}
