import 'package:flutter/material.dart';

import '../../custom_utils/google_maps_helper.dart';
import '../../models/service_request.dart';
import '../../models/vehicle.dart';
import '../../models/vehicle_service.dart';
import '../../service_locator.dart';
import '../../stores/service_request_store.dart';
import 'service_request_details_screen.dart';

class ServiceRequestListScreen extends StatelessWidget {
  ServiceRequestListScreen({Key? key}) : super(key: key);
  static const routeName = '/service-request-list-screen';

  //Custom Utilities
  final GoogleMapsHelper _googleMapsHelper = getIt<GoogleMapsHelper>();

  //Stores
  final ServiceRequestStore _serviceRequestStore = getIt<ServiceRequestStore>();

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.builder(
            itemCount: _serviceRequestStore.serviceRequestList.isEmpty
                ? 1
                : _serviceRequestStore.serviceRequestList.length,
            itemBuilder: (BuildContext context, int index) {
              if (_serviceRequestStore.serviceRequestList.isEmpty) {
                return const Center(
                  child: Text('No Record Found'),
                );
              } else {
                final ServiceRequest currentItem =
                    _serviceRequestStore.serviceRequestList[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ServiceRequestDetailsScreen.routeName);
                  },
                  child: Card(
                      child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary,
                      child: currentItem.vehicleService.vehicleType.getIcon(),
                    ),
                    title: Text(currentItem.vehicleService.serviceName),
                    subtitle:
                        Text(currentItem.vehicleService.serviceType.getName()),
                    trailing: IconButton(
                        onPressed: () async {
                          await _googleMapsHelper.openMap(
                              currentItem.user.userLatLng.latitude,
                              currentItem.user.userLatLng.longitude);
                        },
                        icon: Icon(
                          Icons.location_on,
                          color: theme.colorScheme.primary,
                        )),
                  )),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
