import 'package:car_service_providing_app/models/vehicle.dart';
import 'package:car_service_providing_app/models/vehicle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../custom_utils/google_maps_helper.dart';
import '../../resources/app_images.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../service_locator.dart';
import '../../stores/home_screen_store.dart';
import '../../stores/manage_service_store.dart';
import '../../stores/profile_store.dart';
import '../auth/login_screen.dart';
import '../manage_services/add_service_screen.dart';
import '../service_requests/service_request_list_screen.dart';
import '../shop_profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/shop-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //UI variables
  final double rating = 4.5;

  final int reviewsCount = 703;

  //Stores
  final ManageServiceStore _manageServiceStore = getIt<ManageServiceStore>();

  final ProfileStore _profileStore = getIt<ProfileStore>();

  //Utilities
  final GoogleMapsHelper _googleMapsHelper = getIt<GoogleMapsHelper>();

  @override
  void initState() {
    _profileStore.getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(ProfileScreen.routeName),
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName),
                icon: const Icon(Icons.logout)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    // height: 200,
                    child: buildImage(
                        theme,
                        _profileStore.currentUser?.coverImage ??
                            halfCarWashServiceImage),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _profileStore.currentUser?.name ??
                              'Service Shop Name',
                          style: theme.textTheme.headline3,
                        ),
                        const Expanded(child: SizedBox()),
                        // const Icon(Icons.favorite_border),
                        // const SizedBox(width: 10),
                        IconButton(
                            onPressed: () async {
                              await _googleMapsHelper.openMap(
                                  _profileStore.shopLocation.latitude,
                                  _profileStore.shopLocation.longitude);
                            },
                            icon: const Icon(Icons.location_on_sharp)),
                        const SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              launchUrl(Uri.parse(
                                  "tel://${_profileStore.currentUser?.phone ?? '+9230123456789'}"));
                            },
                            icon: const Icon(Icons.phone)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              '11th downing street, emblem avenue, south park, london',
                              softWrap: true,
                              style: theme.textTheme.headline6,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rating.toString(),
                                  style: theme.textTheme.headline6,
                                ),
                                const SizedBox(width: 10.0),
                                const Icon(Icons.star),
                                const SizedBox(width: 10.0),
                                Text(
                                  '($reviewsCount Reviews)',
                                  style: theme.textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    BookingStats(theme: theme),
                    const SizedBox(height: 20),
                    Observer(builder: (_) {
                      return _carWashServices(context, theme, screenWidth);
                    }),
                    const SizedBox(height: 20),
                    Observer(builder: (_) {
                      return _workshopServices(context, theme, screenWidth);
                    }),
                    const SizedBox(height: 20),
                    Observer(builder: (_) {
                      return _tyreServices(context, theme, screenWidth);
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () =>
              Navigator.of(context).pushNamed(AddServiceScreen.routeName),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.secondary,
          label: const Text('Add Service'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _tyreServices(
      BuildContext context, ThemeData theme, double screenWidth) {
    return Observer(builder: (_) {
      return Column(
        children: [
          Text(
            'Tyre Shop',
            style: theme.textTheme.headline3,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _manageServiceStore.vehicleServiceList
                        .where((element) =>
                            element.serviceType == ServiceType.tyreRepair ||
                            element.serviceType == ServiceType.tyreChange)
                        .isEmpty
                    ? Center(
                        child: Text(
                          'No Record Found',
                          style: theme.textTheme.headline5,
                        ),
                      )
                    : Wrap(
                        alignment: WrapAlignment.spaceAround,
                        runSpacing: 20,
                        children: _manageServiceStore.vehicleServiceList
                            .where((element) => (element.serviceType ==
                                    ServiceType.tyreChange ||
                                element.serviceType == ServiceType.tyreRepair))
                            .map((element) => customImageBox(
                                  screenWidth * 0.4,
                                  theme,
                                  key: ValueKey(element.id),
                                  image: element.coverImage,
                                  title: element.serviceName,
                                  price: element.cost,
                                  onTap: () {
                                    // Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
                                  },
                                ))
                            .toList(),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }

  Widget _workshopServices(
      BuildContext context, ThemeData theme, double screenWidth) {
    return Observer(builder: (_) {
      return Column(
        children: [
          Text(
            'Workshop Services',
            style: theme.textTheme.headline3,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _manageServiceStore.vehicleServiceList
                        .where((element) =>
                            element.serviceType == ServiceType.batteryIssue ||
                            element.serviceType == ServiceType.oilChange ||
                            element.serviceType == ServiceType.carService ||
                            element.serviceType == ServiceType.breakService)
                        .isEmpty
                    ? Center(
                        child: Text(
                          'No Record Found',
                          style: theme.textTheme.headline5,
                        ),
                      )
                    : Wrap(
                        alignment: WrapAlignment.spaceAround,
                        runSpacing: 20,
                        children: _manageServiceStore.vehicleServiceList
                            .where((element) => (element.serviceType ==
                                    ServiceType.batteryIssue ||
                                element.serviceType == ServiceType.oilChange ||
                                element.serviceType == ServiceType.carService ||
                                element.serviceType ==
                                    ServiceType.breakService))
                            .map((element) => customImageBox(
                                  screenWidth * 0.4,
                                  theme,
                                  key: ValueKey(element.id),
                                  image: element.coverImage,
                                  title: element.serviceName,
                                  price: element.cost,
                                  onTap: () {
                                    // Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
                                  },
                                ))
                            .toList(),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }

  Widget _carWashServices(
      BuildContext context, ThemeData theme, double screenWidth) {
    return Observer(builder: (_) {
      return Column(
        children: [
          Text(
            'Car Wash',
            style: theme.textTheme.headline3,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _manageServiceStore.vehicleServiceList
                        .where((element) =>
                            element.serviceType == ServiceType.fullCarWash ||
                            element.serviceType == ServiceType.halfCarWash)
                        .isEmpty
                    ? Center(
                        child: Text(
                          'No Record Found',
                          style: theme.textTheme.headline5,
                        ),
                      )
                    : Wrap(
                        alignment: WrapAlignment.spaceAround,
                        runSpacing: 20,
                        children: _manageServiceStore.vehicleServiceList
                            .where((element) => (element.serviceType ==
                                    ServiceType.fullCarWash ||
                                element.serviceType == ServiceType.halfCarWash))
                            .map((element) => customImageBox(
                                  screenWidth * 0.4,
                                  theme,
                                  key: ValueKey(element.id),
                                  image: element.coverImage,
                                  title: element.serviceName,
                                  price: element.cost,
                                  onTap: () {
                                    // Navigator.of(context).pushNamed(ServiceBookingScreen.routeName);
                                  },
                                ))
                            .toList(),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}

class BookingStats extends StatelessWidget {
  const BookingStats({
    Key? key,
    required this.theme,
    // required this.homeScreenStore,
  }) : super(key: key);

  final ThemeData theme;
//Stores
  // final HomeScreenStore homeScreenStore;

  @override
  Widget build(BuildContext context) {
    return customContainer(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(ServiceRequestListScreen.routeName),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   manageVehicleStore.userVehicleList.length.toString(),
                      //   style: theme.textTheme.headline4,
                      // ),
                      Text(
                        'Orders',
                        style: theme.textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: InkWell(
                  // onTap: () =>
                  //     Navigator.of(context).pushNamed(BookingsScreen.routeName),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Observer(builder: (_) {
                      //   // return Text(
                      //   //   bookServiceStore.serviceRequestList.length.toString(),
                      //   //   style: theme.textTheme.headline4,
                      //   // );
                      // }),
                      Text(
                        'Reviews',
                        style: theme.textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   homeScreenStore.messages.toString(),
                    //   style: theme.textTheme.headline4,
                    // ),
                    Text(
                      'Messages',
                      style: theme.textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
