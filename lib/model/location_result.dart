import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationResult {
  final String name;
  final LatLng location;

  const LocationResult({required this.name, required this.location});
}
