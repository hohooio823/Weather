import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import './SingleCityScreen.dart';
import './SavedCitiesScreen.dart';

import '../Models/City.dart';
/*import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/searchBar.dart';
import '../Widgets/weatherCard.dart';
import '../Widgets/getWeather.dart';
*/

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    SingleCityScreen(City(name: 'Blida', degree: 26, weather: 'Rainy')),
    SavedCitiesScreen(),
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Position? _currentPosition;
  String? _currentAddress;
  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedPageIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
    _getAddressFromLatLng();
    return position;
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      print(place.locality);
      setState(() {
        _currentAddress = "${place.locality}";
      });
    } catch (e) {
      print(e);
    }
  }
}

/*List<String> cities=[];
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
}}*/