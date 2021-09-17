import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddCitiesScreen extends StatefulWidget {
  @override
  _AddCitiesScreenState createState() => _AddCitiesScreenState();
}

class _AddCitiesScreenState extends State<AddCitiesScreen> {
  String city = '';

  Future getCityNames(city) async {
    if (city != '') {
      final response = await http.get(
        Uri.parse(
            "https://api.roadgoat.com/api/v2/destinations/auto_complete?q=$city"),
        headers: {
          'Authorization': 'Basic ' +
              base64Encode(utf8.encode(
                  'd074571aecbcb53bf7f429a4e8c0b5bc:6cf3e1bbbc8922c497b303ac4420595d'))
        },
      );
      var value = response.body != '' ? json.decode(response.body) : null;
      if (value != null) {
        List<Map> data = [];
        value['data']
            .where((city) => city['attributes']['destination_type'] == 'City')
            .forEach((city) => data.add({
                  'name': city['attributes']['short_name'],
                  'fullName': city['attributes']['name']
                }));
        return data;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 6),
                    suffixIcon: Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.blueGrey,
                    ),
                    hintText: 'Enter your city name'),
                cursorColor: Colors.grey,
                onChanged: (text) => setState(() {
                  city = text;
                }),
              )),
          Expanded(
            child: FutureBuilder(
                future: getCityNames(city),
                builder: (ctx, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (cotx, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context, snapshot.data[index]['name']);
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              padding: EdgeInsets.all(10),
                              color: Colors.amber,
                              child: Center(
                                  child:
                                      Text(snapshot.data[index]['fullName']))),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }
}
