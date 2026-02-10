import 'package:flutter/material.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, child: ListTile(
      leading: Icon(Icons.location_on_outlined),
      title: Text('Leaving From'),
    ));
  }
}