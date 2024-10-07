import 'package:flutter/material.dart';
import 'package:ridesense/helpers/validators.dart';
import 'package:ridesense/screens/navigation_middleware.dart';
import 'package:ridesense/widgets/input.dart';
import 'package:ridesense/widgets/primary_button.dart';
import 'package:ridesense/widgets/space.dart';
import 'package:ridesense/widgets/touchable_opacity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationInputScreen extends StatefulWidget {
  static const routeName = '/location_input';
  const LocationInputScreen({super.key});

  @override
  State<LocationInputScreen> createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> recentSearches = [];
  TextEditingController locationNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecentSearches(); // Load the recent searches when the screen is loaded
  }

  // Load recent searches from SharedPreferences
  Future<void> _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recent_searches') ?? [];
    });
  }

  // Save the current search to recent searches
  Future<void> _saveSearchQuery(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentSearches.insert(0, query); // Add to the beginning of the list
    if (recentSearches.length > 5) {
      recentSearches =
          recentSearches.sublist(0, 5); // Keep only the last 5 queries
    }
    await prefs.setStringList('recent_searches', recentSearches);
  }

  // Clear all recent searches
  Future<void> _clearRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_searches');
    setState(() {
      recentSearches.clear();
    });
  }

  void unfocus() {
    FocusScope.of(context).unfocus();
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _saveSearchQuery(
          locationNameController.text); // Save the current search query
      await Navigator.of(context).pushNamed(
          NavigationMiddlewareScreen.routeName,
          arguments: locationNameController.text);
      unfocus();
      locationNameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RideSense'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
          const Space(20),
          if (recentSearches.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Searches',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _clearRecentSearches,
                    child: const Text('Clear Recent'),
                  ),
                ],
              ),
            ),
            for (var search in recentSearches)
              ListTile(
                leading: const Icon(Icons.history),
                title: Text(
                  search,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                onTap: () {
                  locationNameController.text = search;
                  submit();
                },
                trailing: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      recentSearches.remove(search);
                    });
                    _saveSearchQuery(search);
                  },
                ),
              ),
          ],
        ],
      ),
    );
  }
}
