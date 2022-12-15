import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:greatplaces/models/places.dart';
import 'package:greatplaces/utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('Places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: null as PlaceLocation,
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

  void addPlaces(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: null as PlaceLocation,
    );

    _items.add(newPlace);
    DbUtil.insert('Places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
    notifyListeners();
  }
}
