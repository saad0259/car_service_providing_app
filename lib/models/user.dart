import 'package:google_maps_flutter/google_maps_flutter.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String userImage;
  String address;
  String userBio;
  LatLng userLatLng;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userImage,
    required this.address,
    required this.userBio,
    required this.userLatLng,
  });
}
