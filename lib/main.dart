import 'package:flutter/material.dart';
import './Screens/MainPage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      initialRoute: '/',
      routes: {
        '/':(ctx)=>MainPage()
      },
    );
  }
}

