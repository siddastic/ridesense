import 'dart:async';

import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridesense/services/location.dart';
import 'package:ridesense/widgets/input.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // default camera position
  static const CameraPosition _newDelhi = CameraPosition(
    target: LatLng(28.6139, 77.2090),
    zoom: 14.4746,
  );

  LatLng? _currentUserLocation; // Variable to store the current user location
  final Set<Marker> _markers = {}; // To store map markers
  bool isLocationLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      LatLng location = ModalRoute.of(context)!.settings.arguments as LatLng;
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(location));

      // Add search result marker to the map
      _markers.add(Marker(
        markerId: const MarkerId('search_result_marker'),
        position: location,
      ));
      setState(() {});
    });
  }

  // Method to fetch and show current user location using LocationService
  Future<void> _getCurrentLocation() async {
    setState(() {
      isLocationLoading = true;
    });
    try {
      // Get current position using LocationService
      Position position = await LocationService.determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentUserLocation = currentLatLng;

        // Move the camera to the current location
        _controller.future.then((controller) {
          controller
              .animateCamera(CameraUpdate.newLatLng(_currentUserLocation!));
        });

        // Add a blue dot marker for the current location
        _markers.add(Marker(
          markerId: const MarkerId('current_location_marker'),
          position: _currentUserLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    setState(() {
      isLocationLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng searchResult = ModalRoute.of(context)!.settings.arguments as LatLng;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Input(
            prefixIcon: const Icon(Icons.location_on),
            controller: TextEditingController(text: searchResult.toString()),
            readOnly: true,
            padding: const EdgeInsets.all(10),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _newDelhi,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
            ),
          ),
        ],
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
              : const Icon(Icons.my_location)),
    );
  }
}
