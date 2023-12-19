import 'package:flutter/material.dart';
import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

final uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place({required this.title,
   required this.image,
   required this.location
   }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
