import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './AddCitiesScreen.dart';
import './SingleCityScreen.dart';
import './SavedCitiesScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  LocationData? _currentPosition;
  String? _currentCity;
  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void getCityPrefrence() {}
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      GestureDetector(
          onTap: () {
            addCityManually(true);
          },
          child: SingleCityScreen(_currentCity!)),
      SavedCitiesScreen(),
    ];
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
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    _permissionGranted = await location.hasPermission();
    if (_serviceEnabled == true &&
        _permissionGranted == PermissionStatus.granted) {
      _addCityThroughLocation(location);
    }
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        addCityManually();
      } else {
        _addCityThroughLocation(location);
      }
    }
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        addCityManually();
      } else {
        _addCityThroughLocation(location);
      }
    }
    if (_permissionGranted == PermissionStatus.deniedForever) {
      addCityManually();
    }
  }

  _getAddressFromLatLng() async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
              _currentPosition!.latitude!, _currentPosition!.longitude!);
      geocoding.Placemark place = placemarks[0];
      setState(() {
        _currentCity = "${place.locality}";
      });
    } catch (e) {
      print(e);
    }
    if (_currentCity != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('home', _currentCity!);
    }
  }

  addCityManually([bool editMode = false]) async {
    String? city;
    city = await _getCityPref();
    if (city == null || editMode) {
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (ctx) => Scaffold(
                    appBar: AppBar(),
                    body: AddCitiesScreen(),
                  )))
          .then((city) => setState(() {
                _currentCity = city;
              }))
          .then((_) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('home', _currentCity!);
      });
    } else {
      setState(() {
        _currentCity = city;
      });
    }
  }

  _addCityThroughLocation(location) async {
    LocationData position = await location.getLocation();
    setState(() {
      _currentPosition = position;
    });
    _getAddressFromLatLng();
  }

  _getCityPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? city = prefs.getString('home');
    return city;
  }
}
