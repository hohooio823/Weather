import 'package:flutter/material.dart';

import 'Screens/MainScreen.dart';
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
      title: 'Retrieve Text Input',
      initialRoute: '/',
      routes: {'/': (ctx) => MainScreen()},
    );
  }
}
