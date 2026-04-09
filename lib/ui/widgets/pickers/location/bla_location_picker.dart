import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '/data/repositories/location/location_repository_mock.dart';
import '/ui/widgets/display/bla_divider.dart';

import '../../../../model/ride/locations.dart';
import '../../../theme/theme.dart';

class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key, required this.initLocation});

  final Location? initLocation;

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  String searchText = "";

  @override
  void initState() {
    super.initState();

    if (widget.initLocation != null) {
      searchText = widget.initLocation!.name;
    }
  }

  void selectLocation(Location location) {
    Navigator.pop(context, location);
  }

  void goBack() {
    Navigator.pop(context);
  }

  void updateSearch(String value) {
    setState(() {
      searchText = value;
    });
  }

  // ASYNC FUNCTION
  Future<List<Location>> getLocations() async {
    if (searchText.length < 2) return [];

    final repo = context.read<LocationRepositoryMock>();
    final allLocations = await repo.getAllLocations();

    List<Location> result = [];

    for (var loc in allLocations) {
      if (loc.name.toLowerCase().contains(searchText.toLowerCase())) {
        result.add(loc);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(BlaSpacings.m),
        child: Column(
          children: [
            LocationSearchBar(
              initText: searchText,
              onBack: goBack,
              onChanged: updateSearch,
            ),

            SizedBox(height: 20),

            Expanded(
              child: FutureBuilder<List<Location>>(
                future: getLocations(), 
                builder: (context, snapshot) {
                  // Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // No data
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No locations found"));
                  }

                  // Data ready
                  final locations = snapshot.data!;

                  return ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      return LocationTile(
                        location: locations[index],
                        onTap: selectLocation,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------
// Search Bar
// ---------------------
class LocationSearchBar extends StatefulWidget {
  const LocationSearchBar({
    super.key,
    required this.onBack,
    required this.onChanged,
    required this.initText,
  });

  final String initText;
  final VoidCallback onBack;
  final ValueChanged<String> onChanged;

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initText;
  }

  void clearText() {
    setState(() {
      controller.clear();
    });
    widget.onChanged("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.greyLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBack,
            icon: Icon(Icons.arrow_back_ios, size: 16),
          ),

          Expanded(
            child: TextField(
              controller: controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none,
              ),
            ),
          ),

          if (controller.text.isNotEmpty)
            IconButton(onPressed: clearText, icon: Icon(Icons.close, size: 16)),
        ],
      ),
    );
  }
}

// ---------------------
// Location Tile
// ---------------------
class LocationTile extends StatelessWidget {
  const LocationTile({super.key, required this.location, required this.onTap});

  final Location location;
  final Function(Location) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(location),
          leading: Icon(Icons.history),
          title: Text(location.name),
          subtitle: Text(location.country.name),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
        BlaDivider(),
      ],
    );
  }
}
