import 'package:flutter/material.dart';

import '../Widgets/back_button_widget.dart';
import '../Widgets/search_bar_widget.dart';
import '../Widgets/search_results_widget.dart';

class AddCitiesScreen extends StatefulWidget {
  @override
  _AddCitiesScreenState createState() => _AddCitiesScreenState();
}

class _AddCitiesScreenState extends State<AddCitiesScreen> {
  String city = '';
  void SearchBarHandler(text) {
    setState(() {
      city = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BackButtonWidget(),
                SearchBarWidget(SearchBarHandler: SearchBarHandler)
              ],
            ),
            SearchResultsWidget(city: city)
          ],
        ),
      ),
    );
  }
}
