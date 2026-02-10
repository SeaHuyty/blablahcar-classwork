import 'package:blabla/model/ride/locations.dart';
import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback? onTap;

  const LocationTile({super.key, required this.location, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(location.name),
      subtitle: Text(location.country.name),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}