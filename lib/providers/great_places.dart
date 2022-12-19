import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplaces/models/places.dart';
import 'package:greatplaces/utils/db_util.dart';
import '../utils/location_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('Places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                latitude: item['lat'],
                longitude: item['lon'],
                addres: item['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place getItems(int index) {
    return _items[index];
  }

  Future<void> addPlaces(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddresFrom(position);
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          addres: address),
    );

    _items.add(newPlace);
    DbUtil.insert('Places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': position.latitude,
      'lon': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
}
