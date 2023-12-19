import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  // i want to handle <List<Place>>
  UserPlaceNotifier() : super(const []); // pass the intital state inside super

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationCacheDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace =
        Place(title: title, image: copiedImage, location: location);

    final dbpath = await sql.getDatabasesPath();
     
   final db = await  sql.openDatabase(
      path.join(dbpath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY),title TEXT, image TEXT,lat REAL , lng REAL ,address TEXT ');
      },
      version: 1,
    );
    db.insert('user_places', {
      'id' : newPlace.id,
      'title' : newPlace.title,
      'image' : newPlace.image.path,
      'lat' : newPlace.location.latitude,
       'lng' : newPlace.location.longitude,
       'address' : newPlace.location.address,



    });

    state = [
      newPlace,
      ...state
    ]; // ... so that we dont loose previous list itrms
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlaceNotifier, List<Place>>(
  (ref) => UserPlaceNotifier(),
);
