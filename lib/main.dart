import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ridesense/screens/location_input.dart';
import 'package:ridesense/screens/map_screen.dart';
import 'package:ridesense/screens/navigation_middleware.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ridesense',
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: LocationInputScreen.routeName,
      routes: {
        LocationInputScreen.routeName: (context) => const LocationInputScreen(),
        NavigationMiddlewareScreen.routeName: (context) =>
            const NavigationMiddlewareScreen(),
        MapScreen.routeName: (context) => const MapScreen(),
      },
    );
  }
}
