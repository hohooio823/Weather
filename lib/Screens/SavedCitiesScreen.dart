import 'package:flutter/material.dart';

import './SingleCityScreen.dart';
import './AddCitiesScreen.dart';

import 'package:weather/Models/City.dart';

class SavedCitiesScreen extends StatelessWidget {

  Future<dynamic> showCityScreen(BuildContext context,City city){
   return Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Scaffold(appBar:AppBar(),body:SingleCityScreen(City(name: "NYC", weather: "Freezing", degree: -14)))));
 }  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children:[
            Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                child: GestureDetector(
                  child: Card(
                  child: Text('NYC'),
                ),
                onTap: ()=>showCityScreen(context,City(name: "NYC", weather: "Freezing", degree: -14)),
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: GestureDetector(
                  child: Card(
                  child: Text('NYC'),
                ),
                onTap: ()=>showCityScreen(context,City(name: "NYC", weather: "Freezing", degree: -14)),
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: GestureDetector(
                  child: Card(
                  child: Text('NYC'),
                ),
                onTap: ()=>showCityScreen(context,City(name: "NYC", weather: "Freezing", degree: -14)),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),child: FloatingActionButton(child:Text('+'),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Scaffold(appBar:AppBar(),body: AddCitiesScreen(),)));
            }))
            ,
        ]
      ),
    );
  }
}