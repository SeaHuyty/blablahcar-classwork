import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/ui/screens/ride/widgets/location_tile.dart';
import 'package:flutter/material.dart';

class RideScreen extends StatefulWidget {
  final Location? departure;
  final Location? arrival;
  const RideScreen({super.key, this.departure, this.arrival});

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  final TextEditingController locationController = TextEditingController();
  List<Location> filterLocation = [];
  List<Location> validateLocations = [];

  @override
  void initState() {
    validateLocations = fakeLocations
        .where(
          (location) =>
              location != widget.departure && location != widget.arrival,
        )
        .toList();
    filterLocation = validateLocations;
    super.initState();
  }

  void filter(String searchInput) {
    setState(() {
      filterLocation = validateLocations
          .where(
            (location) =>
                (location.name.toLowerCase().contains(
                  searchInput.toLowerCase(),
                ) ||
                location.country.name.toLowerCase().contains(
                  searchInput.toLowerCase(),
                )),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 231, 231, 231),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: locationController,
                            onChanged: filter,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hint: Text('Search your location'),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            locationController.clear();
                            setState(() {
                              filterLocation = validateLocations;
                            });
                          },
                          icon: Icon(Icons.close),
                          color: const Color.fromARGB(255, 123, 123, 123),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterLocation.length,
              itemBuilder: (context, index) => LocationTile(
                location: filterLocation[index],
                onTap: () {
                  Navigator.pop(context, filterLocation[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
