import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place.dart';

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  // i want to handle <List<Place>>
  UserPlaceNotifier() : super(const []); // pass the intital state inside super

  void addPlace(String title) {
    final newPlace = Place(title: title);
    state = [
      newPlace,
      ...state
    ]; // ... so that we dont loose previous list itrms
  }
}

final userPlacesProvider = StateNotifierProvider((ref) => 
UserPlaceNotifier(),
);
