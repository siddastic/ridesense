import 'package:flutter/material.dart';
import 'package:ridesense/screens/location_input.dart';
import 'package:ridesense/screens/navigation_middleware.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      themeMode: ThemeMode.system,
      initialRoute: LocationInputScreen.routeName,
      routes: {
        LocationInputScreen.routeName: (context) => const LocationInputScreen(),
        NavigationMiddlewareScreen.routeName: (context) =>
            const NavigationMiddlewareScreen(),
      },
    );
  }
}
