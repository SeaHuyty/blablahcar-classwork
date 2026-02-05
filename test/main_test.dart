import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/rides_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test the filter method', () {
    final result = RidesService.filterBy(
      departure: Location(name: "Dijon", country: Country.france),
      seatRequested: 2,
    ); // Shall return 1 ride

    expect(result.length, 1);
  });
}
