import 'package:flutter/material.dart';
import 'package:app/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key, required this.locationData});

  final LocationData locationData;

  static const route = "/location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(locationData.latitude, locationData.longitude),
          zoom: 14.4746,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("location"),
            position: LatLng(locationData.latitude, locationData.longitude),
          ),
        },
      ),
    );
  }
}
