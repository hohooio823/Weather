import 'package:flutter/material.dart';

import 'Screens/main_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///
  /// Force the layout to Portrait mode
  ///
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {'/': (ctx) => MainScreen()},
    );
  }
}
