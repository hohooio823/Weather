import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

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
      _currentCity != null
          ? SingleCityScreen(
              cityName: _currentCity!, changeCity: addCityManually)
          : Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            )),
      SavedCitiesScreen(),
    ];
    _currentCity = 'blida';
    return Scaffold(
      body: SafeArea(child: _pages[_selectedPageIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.globe),
            label: 'Worldwide',
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
                    body: AddCitiesScreen(),
                  )))
          .then((city) => city != null
              ? setState(() {
                  _currentCity = city;
                })
              : null)
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
