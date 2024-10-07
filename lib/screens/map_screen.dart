import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // animate camera to the search result
      LatLng location = ModalRoute.of(context)!.settings.arguments as LatLng;
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(location));
    });
    super.initState();
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
              markers: {
                Marker(
                  markerId: MarkerId('search_result_marker'),
                  position: searchResult,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
