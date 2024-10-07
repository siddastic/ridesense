import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridesense/widgets/space.dart';

class MapTypeSelector extends StatelessWidget {
  final MapType currentMapType;
  final ValueChanged<MapType> onMapTypeChanged;

  const MapTypeSelector({
    super.key,
    required this.currentMapType,
    required this.onMapTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Map Type',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 20,
              ),
            ),
            Space.def,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMapTypeButton(
                  context,
                  type: MapType.normal,
                  label: 'Normal',
                  imageAsset:
                      'assets/images/default.png', // Replace with actual image assets
                ),
                _buildMapTypeButton(
                  context,
                  type: MapType.hybrid,
                  label: 'Hybrid',
                  imageAsset:
                      'assets/images/hybrid.png', // Replace with actual image assets
                ),
                _buildMapTypeButton(
                  context,
                  type: MapType.satellite,
                  label: 'Satellite',
                  imageAsset:
                      'assets/images/satellite.jpg', // Replace with actual image assets
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapTypeButton(
    BuildContext context, {
    required MapType type,
    required String label,
    required String imageAsset,
  }) {
    return GestureDetector(
      onTap: () => onMapTypeChanged(type),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageAsset),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: currentMapType == type ? Colors.blue : Colors.black,
                width: 2,
              ),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: currentMapType == type ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
