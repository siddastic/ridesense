import 'package:flutter/material.dart';
import 'package:ridesense/helpers/validators.dart';
import 'package:ridesense/screens/navigation_middleware.dart';
import 'package:ridesense/widgets/input.dart';
import 'package:ridesense/widgets/primary_button.dart';
import 'package:ridesense/widgets/space.dart';
import 'package:ridesense/widgets/touchable_opacity.dart';

class LocationInputScreen extends StatefulWidget {
  static const routeName = '/location_input';
  const LocationInputScreen({super.key});

  @override
  State<LocationInputScreen> createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController locationNameController = TextEditingController();

  void unfocus() {
    FocusScope.of(context).unfocus();
  }

  void submit() {
    unfocus();
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushNamed(NavigationMiddlewareScreen.routeName,
          arguments: locationNameController.text);
    }
  }

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
            key: _formKey,
            child: Hero(
              tag: 'location_input',
              child: Input(
                validator: Validators.Required(
                  errorMessage: 'Enter a location',
                  next: Validators.MinLength(
                    length: 3,
                    errorMessage:
                        'Location name is too short (min 3 characters)',
                  ),
                ),
                controller: locationNameController,
                autofillHints: const [AutofillHints.addressCityAndState],
                prefixIcon: const Icon(Icons.location_on),
                suffixIcon: locationNameController.text.isEmpty
                    ? null
                    : TouchableOpacity(
                        onTap: () {
                          unfocus();
                          locationNameController.clear();
                        },
                        child: const Icon(Icons.clear),
                      ),
                keyboardType: TextInputType.streetAddress,
                hint: 'Where do you wanna go?',
                onChanged: (value) {
                  setState(() {});
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
                onPressed: locationNameController.text.isEmpty ? null : submit,
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
