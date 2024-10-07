import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:ridesense/model/location_result.dart';
import 'package:ridesense/screens/map_screen.dart';
import 'package:ridesense/services/location.dart';
import 'package:ridesense/widgets/input.dart';
import 'package:ridesense/widgets/space.dart';

class NavigationMiddlewareScreen extends StatefulWidget {
  static const routeName = '/navigation_middleware';
  const NavigationMiddlewareScreen({super.key});

  @override
  State<NavigationMiddlewareScreen> createState() =>
      _NavigationMiddlewareScreenState();
}

class _NavigationMiddlewareScreenState
    extends State<NavigationMiddlewareScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loadResults();
    });
    super.initState();
  }

  void loadResults() async {
    try {
      var query = ModalRoute.of(context)!.settings.arguments as String;
      LatLng location = await LocationService.getCoordinates(query);
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pushReplacementNamed(
        MapScreen.routeName,
        arguments: LocationResult(
          name: query,
          location: location,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not find location$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String location = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Lottie.network(
            'https://lottie.host/f3bd011d-7dae-4219-94e8-5ac0cfffaeb0/ll09yQ6Jg8.json',
            width: 200,
            height: 200,
          ),
          const Space(50),
          const Text("Looking for a place like this"),
          const Spacer(),
          Hero(
            tag: 'location_input',
            child: Input(
              controller: TextEditingController(text: location),
              prefixIcon: const Icon(Icons.location_on),
              hint: 'Where do you wanna go?',
              readOnly: true,
            ),
          ),
          Space.def,
          Hero(
            tag: "search_button",
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
                shape: BoxShape.circle,
              ),
              child: CupertinoActivityIndicator(
                color: Theme.of(context).dialogBackgroundColor,
              ),
            ),
          ),
          const Space(100),
        ],
      ),
    );
  }
}
