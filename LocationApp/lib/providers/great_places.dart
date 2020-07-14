import 'package:LocationApp/models/place.dart';
import 'package:flutter/widgets.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  
  List<Place> get items {
    return [...items];
  }
}