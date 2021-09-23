import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function SearchBarHandler;
  const SearchBarWidget({required this.SearchBarHandler});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.075,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).accentColor,
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 6),
              suffixIcon: Icon(
                Icons.search,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              hintText: 'Enter your city name'),
          cursorColor: Theme.of(context).primaryColor,
          onChanged: (text) {
            SearchBarHandler(text);
          },
        ));
  }
}
