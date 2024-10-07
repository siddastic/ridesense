import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<LatLng> getCoordinates(String location) async {
    List<Location> locations = await locationFromAddress(location);
    return LatLng(locations[0].latitude, locations[0].longitude);
  }
}
