import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceShop {
  String id;
  String name;
  String coverImage;
  double rating;
  String address;
  TimeOfDay openingTime;
  TimeOfDay closingTime;
  LatLng shopLocation;
  ServiceShop({
    required this.id,
    required this.name,
    required this.address,
    required this.openingTime,
    required this.closingTime,
    required this.coverImage,
    required this.rating,
    required this.shopLocation,
  });
}
