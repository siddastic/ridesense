import 'dart:async';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridesense/model/location_result.dart';
import 'package:ridesense/services/location.dart';
import 'package:ridesense/widgets/input.dart';
import 'package:ridesense/widgets/map_type_selector.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _newDelhi = CameraPosition(
    target: LatLng(28.6139, 77.2090),
    zoom: 14.4746,
  );

  final Set<Marker> _markers = {};
  bool isLocationLoading = false;
  MapType _mapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      LocationResult result =
          ModalRoute.of(context)!.settings.arguments as LocationResult;
      _animateCameraToLocation(result.location);
      _addMarker(result.location, 'search_result_marker');
    });
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLocationLoading = true;
    });
    try {
      Position position = await LocationService.determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      _animateCameraToLocation(currentLatLng);
      _addMarker(
          currentLatLng, 'current_location_marker', BitmapDescriptor.hueBlue);
    } catch (e) {
      _showErrorSnackBar(e.toString());
    }
    setState(() {
      isLocationLoading = false;
    });
  }

  void _animateCameraToLocation(LatLng location) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(location));
  }

  void _addMarker(LatLng position, String markerId,
      [double hue = BitmapDescriptor.hueRed]) {
    _markers.add(Marker(
      markerId: MarkerId(markerId),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(hue),
    ));
    setState(() {});
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    LocationResult searchResult =
        ModalRoute.of(context)!.settings.arguments as LocationResult;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Input(
            prefixIcon: const Icon(Icons.location_on),
            controller: TextEditingController(text: searchResult.name),
            readOnly: true,
            padding: const EdgeInsets.all(10),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              zoomControlsEnabled: false,
              mapType: _mapType,
              initialCameraPosition: _newDelhi,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
            ),
          ),
        ],
      ),
      bottomNavigationBar: MapTypeSelector(
        currentMapType: _mapType,
        onMapTypeChanged: (MapType type) {
          setState(() {
            _mapType = type;
          });
        },
      ),
      floatingActionButtonLocation: isLocationLoading
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: isLocationLoading ? null : _getCurrentLocation,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: isLocationLoading
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.my_location),
      ),
    );
  }
}
