import 'package:flutter/material.dart';

import '../Helpers/getCityNames.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({
    required this.city,
  });

  final String city;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: getCityNames(city),
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (cotx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, snapshot.data[index]['name']);
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        padding: EdgeInsets.all(10),
                        color: Theme.of(context).primaryColor,
                        child: Center(
                            child: Text(snapshot.data[index]['fullName'],
                                style: TextStyle(
                                    color: Theme.of(context).accentColor)))),
                  );
                },
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
