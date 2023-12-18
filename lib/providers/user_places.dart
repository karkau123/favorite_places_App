import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place.dart';
import 'dart:io';
class UserPlaceNotifier extends StateNotifier<List<Place>> {
  // i want to handle <List<Place>>
  UserPlaceNotifier() : super(const []); // pass the intital state inside super

  void addPlace(String title,File image) {
    final newPlace = Place(title: title,image: image);
    state = [
      newPlace,
      ...state
    ]; // ... so that we dont loose previous list itrms
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlaceNotifier,List<Place>>
((ref) => 
UserPlaceNotifier(),
);
