import 'package:flutter/material.dart';
import 'package:weather/Models/City.dart';

import './SingleCityScreen.dart';
class SavedCitiesScreen extends StatelessWidget {

  Future<dynamic> showCityScreen(BuildContext context,City city){
   return Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Scaffold(appBar:AppBar(),body:SingleCityScreen(City(name: "NYC", weather: "Freezing", degree: -14)))));
 }  

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}