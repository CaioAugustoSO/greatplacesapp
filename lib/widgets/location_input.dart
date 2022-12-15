import 'package:flutter/material.dart';
import 'package:greatplaces/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      longitude: locData.longitude,
      latitude: locData.latitude,
    );
    setState(() {
      _previewImageURL = staticMapImageUrl;
    });
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
                ? Text("nenuma localização informada")
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
              onPressed: () {},
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
