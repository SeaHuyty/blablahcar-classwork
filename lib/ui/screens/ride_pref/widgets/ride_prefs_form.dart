import 'package:blabla/ui/screens/ride/ride_screen.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:blabla/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  final TextEditingController passengerController = TextEditingController();

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------
  @override
  void initState() {
    super.initState();
    passengerController.text = '1';
    departureDate = DateTime.now();
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  Future<void> pickDate() async {
    final DateTime? chosen = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.utc(DateTime.now().year, 12, 31),
    );

    if (chosen != null) {
      setState(() {
        departureDate = chosen;
      });
    }
  }

  Future<void> pickLocation(bool isDeparture) async {
    final Location? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RideScreen(departure: departure, arrival: arrival),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        isDeparture ? departure = selectedLocation : arrival = selectedLocation;
      });
    }
  }

  void switchLocation() {
    setState(() {
      final Location? tempLocation = departure;
      departure = arrival;
      arrival = tempLocation;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () => pickLocation(true),
              child: ListTile(
                leading: Icon(Icons.location_on, color: BlaColors.iconLight),
                title: Text(
                  departure == null ? 'Leaving From' : departure!.name,
                  style: TextStyle(
                    color: departure == null ? BlaColors.iconLight : null,
                  ),
                ),
              ),
            ),
            Divider(indent: 35, endIndent: 35),
            TextButton(
              onPressed: () => pickLocation(false),
              child: ListTile(
                leading: Icon(Icons.location_on, color: BlaColors.iconLight),
                title: Text(
                  arrival == null ? 'Going To' : arrival!.name,
                  style: TextStyle(
                    color: arrival == null ? BlaColors.iconLight : null,
                  ),
                ),
              ),
            ),
            Divider(indent: 35, endIndent: 35),
            TextButton(
              onPressed: pickDate,
              child: ListTile(
                leading: Icon(
                  Icons.calendar_today_outlined,
                  color: BlaColors.iconLight,
                ),
                title: Text(DateTimeUtils.formatDateTime(departureDate)),
              ),
            ),

            Divider(indent: 35, endIndent: 35),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: ListTile(
                leading: Icon(
                  Icons.person_outline_outlined,
                  color: BlaColors.iconLight,
                ),
                title: TextField(
                  controller: passengerController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            BlaButton(isPrimary: true, title: 'Search'),
          ],
        ),
        Positioned(
          right: 5,
          child: IconButton(
            onPressed: switchLocation,
            icon: Icon(Icons.swap_vert_outlined, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
