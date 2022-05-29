import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../custom_utils/google_maps_helper.dart';
import '../../models/service_request.dart';
import '../../models/vehicle.dart';
import '../../models/vehicle_service.dart';
import '../../service_locator.dart';
import '../../stores/service_request_store.dart';
import 'service_request_details_screen.dart';

class ServiceRequestListScreen extends StatefulWidget {
  ServiceRequestListScreen({Key? key}) : super(key: key);
  static const routeName = '/service-request-list-screen';

  @override
  State<ServiceRequestListScreen> createState() =>
      _ServiceRequestListScreenState();
}

class _ServiceRequestListScreenState extends State<ServiceRequestListScreen> {
  //Custom Utilities
  final GoogleMapsHelper _googleMapsHelper = getIt<GoogleMapsHelper>();

  //Stores
  final ServiceRequestStore _serviceRequestStore = getIt<ServiceRequestStore>();

  @override
  void initState() {
    _serviceRequestStore.loadAllServiceRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Observer(builder: (_) {
        return _serviceRequestStore.isLoadingOrders
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            : Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await _serviceRequestStore.loadAllServiceRequests();
                    },
                    child: ListView.builder(
                      itemCount: (_serviceRequestStore.serviceRequestList
                                  .where((element) =>
                                      element.serviceRequestStatus ==
                                      ServiceRequestStatus.idle)
                                  .toList()
                                  .isEmpty &&
                              _serviceRequestStore.serviceRequestList
                                  .where((element) =>
                                      element.serviceRequestStatus ==
                                      ServiceRequestStatus.inprogress)
                                  .toList()
                                  .isEmpty &&
                              _serviceRequestStore.serviceRequestList
                                  .where((element) =>
                                      element.serviceRequestStatus ==
                                      ServiceRequestStatus.accepted)
                                  .toList()
                                  .isEmpty)
                          ? 1
                          : _serviceRequestStore.serviceRequestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isNotIdle = _serviceRequestStore.serviceRequestList
                            .where((element) =>
                                element.serviceRequestStatus ==
                                ServiceRequestStatus.idle)
                            .toList()
                            .isEmpty;
                        bool isNotInProgress = _serviceRequestStore
                            .serviceRequestList
                            .where((element) =>
                                element.serviceRequestStatus ==
                                ServiceRequestStatus.inprogress)
                            .toList()
                            .isEmpty;
                        bool isNotAccepted = _serviceRequestStore
                            .serviceRequestList
                            .where((element) =>
                                element.serviceRequestStatus ==
                                ServiceRequestStatus.accepted)
                            .toList()
                            .isEmpty;

                        if (isNotIdle && isNotInProgress && isNotAccepted) {
                          return const Center(
                            child: Text('No Record Found'),
                          );
                        } else {
                          final ServiceRequest currentItem =
                              _serviceRequestStore.serviceRequestList[index];
                          return currentItem.serviceRequestStatus !=
                                      ServiceRequestStatus.idle &&
                                  currentItem.serviceRequestStatus !=
                                      ServiceRequestStatus.inprogress &&
                                  currentItem.serviceRequestStatus !=
                                      ServiceRequestStatus.accepted
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        ServiceRequestDetailsScreen.routeName,
                                        arguments: {
                                          'serviceRequest': currentItem
                                        });
                                  },
                                  child: Card(
                                      child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          theme.colorScheme.primary,
                                      child: currentItem
                                          .vehicleService.vehicleType
                                          .getIcon(),
                                    ),
                                    title: Text(
                                        currentItem.vehicleService.serviceName),
                                    subtitle: Text(currentItem
                                        .vehicleService.serviceType
                                        .getName()),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(currentItem.serviceRequestStatus
                                            .getName()),
                                        const SizedBox(width: 20),
                                        IconButton(
                                            onPressed: () async {
                                              await _googleMapsHelper.openMap(
                                                  currentItem
                                                      .userLocation.latitude,
                                                  currentItem
                                                      .userLocation.longitude);
                                            },
                                            icon: Icon(
                                              Icons.location_on,
                                              color: theme.colorScheme.primary,
                                            )),
                                      ],
                                    ),
                                  )),
                                );
                        }
                      },
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
