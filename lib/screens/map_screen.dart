import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // new delhi
  LatLng _coordinates = const LatLng(28.6139, 77.2090);
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _coordinates,
              zoom: 12,
            ),
            markers: {
              Marker(
                markerId: MarkerId('location_marker'),
                position: _coordinates,
              ),
            },
          ),
        ],
      ),
    );
  }
}
