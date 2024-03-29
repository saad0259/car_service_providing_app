import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../custom_utils/general_helper.dart';
import '../../custom_utils/google_maps_helper.dart';

class GetLocationScreen extends StatefulWidget {
  static const routeName = '/get-location-screen';
  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  String googleApikey = "AIzaSyDGVdifKHexYzYZjIF615HPm5e00AzqO4g";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
  LatLng responseLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
  Future<void> getCurrentUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        log('Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        log('new position var : ${position.latitude} , ${position.longitude}');
        setState(() {
          startLocation = LatLng(position.latitude, position.longitude);
          log('updated Location : $startLocation');
          mapController?.animateCamera(CameraUpdate.newLatLng(startLocation));
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    //route Data handeling
    dynamic routeData = modalRouteHandler(context);
    final LatLng? receivedLocation = routeData?['startLocation'] as LatLng?;

    // if (receivedLocation != null) {
    //   setState(() {
    //     mapController?.animateCamera(CameraUpdate.newLatLng(receivedLocation));
    //   });
    // }
    //else {
    // getCurrentUserLocation();
    // }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Google Maps"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            // zoomGesturesEnabled: true, //  enable Zoom in, out on map
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            // zoomGesturesEnabled: false,
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 14.0, //initial zoom level
            ),
            mapType: MapType.normal, //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              cameraPosition = cameraPositiona; //when map is dragging
            },
            onCameraIdle: () async {
              // setState(() {
              responseLocation = LatLng(cameraPosition!.target.latitude,
                  cameraPosition!.target.longitude);
              // });
            },
          ),
          Center(
            //picker image on google map
            child: Icon(
              Icons.location_on,
              size: 40,
              color: theme.colorScheme.error,
            ),
          ),
          Positioned(
              //widget to display location name
              bottom: 10,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    width: 100,

                    // child: ListTile(
                    //   leading: const Icon(Icons.location_on),
                    //   title: Column(
                    //     children: [
                    //       Text(
                    //         startLocation.latitude.toStringAsFixed(5),
                    //         style: const TextStyle(fontSize: 18),
                    //       ),
                    //       Text(
                    //         startLocation.longitude.toStringAsFixed(5),
                    //         style: const TextStyle(fontSize: 18),
                    //       ),
                    //     ],
                    //   ),
                    //   dense: true,
                    //   trailing: IconButton(
                    //       onPressed: () {
                    //         Navigator.of(context).pop(responseLocation);
                    //       },
                    //       icon: Icon(
                    //         Icons.check,
                    //         color: theme.colorScheme.primary,
                    //       )),
                    // ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(responseLocation);
                        },
                        icon: Icon(
                          Icons.check,
                          color: theme.colorScheme.primary,
                        )),
                  ),
                ),
              ))
        ]));
  }
}
