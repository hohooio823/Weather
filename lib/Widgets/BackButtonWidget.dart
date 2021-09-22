import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        mini: true,
        child: Icon(Icons.arrow_back, color: Theme.of(context).accentColor),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }
}
