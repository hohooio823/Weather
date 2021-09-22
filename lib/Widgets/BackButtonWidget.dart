import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.black,
        mini: true,
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }
}
