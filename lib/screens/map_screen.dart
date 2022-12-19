import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplaces/models/places.dart';

class MapScreen extends StatefulWidget {
  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.419857, longitude: -122.078827),
    this.isreadonly = false,
  });

  final PlaceLocation initialLocation;

  final bool isreadonly;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (!widget.isreadonly)
            IconButton(
                onPressed: _pickedPosition == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedPosition);
                      },
                icon: Icon(Icons.check))
        ],
        title: const Text("Selecione..."),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 13,
        ),
        onTap: widget.isreadonly ? null : _selectPosition,
        markers: (_pickedPosition == null && !widget.isreadonly)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('p1'),
                  position:
                      _pickedPosition ?? widget.initialLocation.toLatLng(),
                ),
              },
      ),
    );
  }
}
