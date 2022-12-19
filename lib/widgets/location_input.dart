import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplaces/screens/map_screen.dart';
import 'package:greatplaces/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  LocationInput(this.onselectPosition);

  final Function onselectPosition;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

  void _showPreview(double lat, double lon) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      longitude: lon,
      latitude: lat,
    );
    setState(() {
      _previewImageURL = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude as double, locData.longitude as double);
      widget.onselectPosition(LatLng(
        locData.latitude as double,
        locData.longitude as double,
      ));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectonMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => MapScreen(), fullscreenDialog: true),
    );

    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude as double,
        selectedPosition.longitude as double);
    widget.onselectPosition(selectedPosition);

    print(selectedPosition.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _previewImageURL == null
                ? Text("Nenhuma localização informada")
                : Image.network(
                    _previewImageURL!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor),
              icon: Icon(Icons.location_on),
              label: Text('Localização Atual'),
            ),
            TextButton.icon(
              onPressed: _selectonMap,
              style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor),
              icon: Icon(Icons.map),
              label: Text('Escolha a localização'),
            )
          ],
        )
      ],
    );
  }
}
