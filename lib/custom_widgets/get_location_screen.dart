import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocationScreen extends StatefulWidget {
  static const routeName = '/get-location-screen';
  @override
  _GetLocationScreenState createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen> {
  String googleApikey = "AIzaSyDGVdifKHexYzYZjIF615HPm5e00AzqO4g";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(27.6602292, 85.308027);
  LatLng location = const LatLng(27.6602292, 85.308027);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Longitude Latitude Picker in Google Map"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
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
              setState(() {
                location = LatLng(cameraPosition!.target.latitude,
                    cameraPosition!.target.longitude);
              });
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
              bottom: 100,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Card(
                  child: Container(
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width - 40,
                      child: ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Column(
                          children: [
                            Text(
                              location.latitude.toStringAsFixed(5),
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              location.longitude.toStringAsFixed(5),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        dense: true,
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop(location);
                            },
                            icon: Icon(
                              Icons.check,
                              color: theme.colorScheme.primary,
                            )),
                      )),
                ),
              ))
        ]));
  }
}
