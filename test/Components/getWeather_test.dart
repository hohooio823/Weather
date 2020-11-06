import 'package:Weather/Components/getWeather.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given city name sf When getWeather is called Then City_Name is San Francisco ', () async {
    //  ARRANGE
    final city = 'sf';

    // ACT
    final data = await getWeather(city);

    // ASSERT
    expect(data['city_name'],'San Francisco');

  });
}