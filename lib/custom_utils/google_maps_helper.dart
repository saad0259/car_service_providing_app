import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapsHelper {
  final LatLng defaultGoogleMapsLocation = const LatLng(31.5116835, 74.3330131);

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      print('Could not open the map.');
    }
  }
}
