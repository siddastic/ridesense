import 'package:flutter/material.dart';
import 'package:ridesense/widgets/input.dart';
import 'package:ridesense/widgets/primary_button.dart';
import 'package:ridesense/widgets/space.dart';

class LocationInputScreen extends StatefulWidget {
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
          const Text.rich(
            TextSpan(
              text: "Map Explorer",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
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
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: PrimaryButton(
              onPressed: () {},
              label: 'Search',
            ),
          ),
        ],
      ),
    );
  }
}
