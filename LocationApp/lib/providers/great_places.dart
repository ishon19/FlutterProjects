import 'dart:io';

import 'package:LocationApp/models/place.dart';
import 'package:flutter/widgets.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [...items];
  }

  void addPlace(String title, File image) {
    print('[AddPlace] Inside');
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: image,
    );

    _items.add(newPlace);
    notifyListeners();
  }
}
