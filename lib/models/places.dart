import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? addres;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.addres,
  });
}

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  Place({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });
}