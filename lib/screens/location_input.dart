import 'package:flutter/material.dart';
import 'package:ridesense/screens/navigation_middleware.dart';
import 'package:ridesense/widgets/input.dart';
import 'package:ridesense/widgets/primary_button.dart';
import 'package:ridesense/widgets/space.dart';

class LocationInputScreen extends StatefulWidget {
  static const routeName = '/location_input';
  const LocationInputScreen({super.key});

  @override
  State<LocationInputScreen> createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController locationNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RideSense'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const Space(100),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Hero(
              tag: 'location_input',
              child: Input(
                controller: locationNameController,
                autofillHints: const [AutofillHints.addressCityAndState],
                prefixIcon: const Icon(Icons.location_on),
                suffixIcon: const Icon(Icons.clear),
                hint: 'Where do you wanna go?',
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {});
                  }
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Hero(
              tag: 'search_button',
              child: PrimaryButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(NavigationMiddlewareScreen.routeName);
                },
                label: 'Go',
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
