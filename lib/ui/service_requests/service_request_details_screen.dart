import 'package:intl/intl.dart';

import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../models/service_request.dart';
import 'package:flutter/material.dart';

import '../../custom_utils/general_helper.dart';
import '../../service_locator.dart';
import '../../stores/service_request_store.dart';

class ServiceRequestDetailsScreen extends StatelessWidget {
  ServiceRequestDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/booking-details-screen';

  //Custom Utils
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  //Stores
  final ServiceRequestStore _serviceRequestStore = getIt<ServiceRequestStore>();

  //Functions
  Future<void> updateRequestStatus(
      BuildContext context, String serviceRequestId) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    _customAlerts.showLoaderDialog(context);
    fResponse = await _connectivityHelper.checkInternetConnection();
    if (fResponse.success) {
      fResponse = await _serviceRequestStore.updateRequsetStatus(
          serviceRequestId, ServiceRequestStatus.completed);
      _serviceRequestStore.loadAllServiceRequests();
    }
    _customAlerts.popLoader(context);

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
    if (fResponse.success) {
      //Go back
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    //route Data handeling
    dynamic routeData = modalRouteHandler(context);
    final ServiceRequest serviceRequest = routeData['serviceRequest'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                customContainer(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _customListItem(
                          theme,
                          'Date',
                          DateFormat('kk:mm a - d M y')
                              .format(serviceRequest.dateTime)),
                      _customListItem(
                          theme,
                          'Type',
                          serviceRequest.isMobile
                              ? 'Mobile Service'
                              : ' Normal Booking'),
                      _customListItem(theme, 'Shop Name',
                          serviceRequest.vehicleService.shopName),
                      _customListItem(theme, 'Cost',
                          serviceRequest.vehicleService.cost.toString()),
                      _customListItem(theme, 'Status',
                          serviceRequest.serviceRequestStatus.getName()),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await updateRequestStatus(context, serviceRequest.id);
                        },
                        child: const Text('Mark Completed'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customListItem(ThemeData theme, String key, String value) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      key,
                      style: theme.textTheme.headline5,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      value,

                      softWrap: true,
                      style: theme.textTheme.headline5,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
