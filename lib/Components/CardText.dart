import 'package:flutter/material.dart';

class CardText extends StatefulWidget {
  String text;
  double fntSize;
  IconData icon;
  CardText(this.text,[this.fntSize=14,this.icon]);
  @override
  _CardTextState createState() => _CardTextState();
}
class _CardTextState extends State<CardText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children:<Widget>[
        Icon(widget.icon),
        Text(
                          widget.text,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                            fontSize: widget.fntSize,
                          ),
                        ),
      ]
    );
  }
}