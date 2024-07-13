import 'package:flutter/material.dart';
import 'package:app/local_database/db_position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key, required this.position});

  final DBPosition position;

  static const route = "/location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.4746,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("position"),
            position: LatLng(position.latitude, position.longitude),
          ),
        },
      ),
    );
  }
}
