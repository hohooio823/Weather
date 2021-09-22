import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
