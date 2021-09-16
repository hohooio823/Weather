import 'package:flutter/material.dart';

import '../Models/City.dart';

class SingleCityScreen extends StatelessWidget {
  
  City city ;

  SingleCityScreen(this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(city.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(city.degree.toString()),
              Text(city.weather)
            ],
          )
        ],
      ),
    );
  }
}