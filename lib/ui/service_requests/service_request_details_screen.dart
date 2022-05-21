import 'package:car_service_providing_app/custom_widgets/custom_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/service_request.dart';
import '../../models/vehicle_service.dart';
import '../../service_locator.dart';
import '../../stores/service_request_store.dart';

class ServiceRequestDetailsScreen extends StatelessWidget {
  ServiceRequestDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/service-request-details-screen';

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Service Request Details',
                  style: theme.textTheme.headline3,
                ),
                const SizedBox(height: 20),
                customContainer(
                  child: Column(
                    children: [
                      customContainer(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            _customListItem(
                                theme,
                                'Date',
                                DateFormat('d M y - kk:mm a').format(
                                    _serviceRequestStore
                                        .serviceRequestList.first.dateTime)),
                            _customListItem(
                                theme,
                                'Status',
                                _serviceRequestStore.serviceRequestList.first
                                    .serviceRequestStatus
                                    .getName()),
                            _customListItem(
                                theme,
                                'Serivice Type',
                                _serviceRequestStore.serviceRequestList.first
                                    .vehicleService.serviceType
                                    .getName()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        style: theme.textButtonTheme.style?.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                              theme.colorScheme.primary),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: const Text('Start Service'),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _customListItem(ThemeData _theme, String key, String value) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      key,
                      style: _theme.textTheme.headline5,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      value,

                      softWrap: true,
                      style: _theme.textTheme.headline5,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const Divider(),
    ],
  );
}
