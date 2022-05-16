import 'package:car_service_providing_app/custom_utils/google_maps_helper.dart';
import 'package:car_service_providing_app/models/user.dart';
import 'package:car_service_providing_app/models/vehicle_service.dart';
import 'package:car_service_providing_app/resources/app_images.dart';
import 'package:mobx/mobx.dart';

import '../models/service_request.dart';
import '../models/vehicle.dart';

part 'service_request_store.g.dart';

class ServiceRequestStore = _ServiceRequestStore with _$ServiceRequestStore;

abstract class _ServiceRequestStore with Store {
  @observable
  ObservableList<ServiceRequest> serviceRequestList =
      ObservableList<ServiceRequest>.of([
    ServiceRequest(
      id: '123',
      user: User(
          id: '123',
          firstName: 'Hammad',
          lastName: 'Khalid',
          email: 'abc@gmail.com',
          userImage: fullCarServiceImage,
          address: 'address',
          userBio: 'userBio',
          userLatLng: GoogleMapsHelper().defaultGoogleMapsLocation),
      paymentMethod: PaymentMethod.cash,
      dateTime: DateTime.now(),
      vehicleService: VehicleService(
          id: '123',
          shopId: '123',
          coverImage: fullCarWashServiceImage,
          shopName: 'Shop name ',
          serviceName: 'full car service name',
          description: 'description',
          serviceType: ServiceType.carService,
          vehicleType: VehicleType.bike,
          rating: 2.2,
          cost: 100,
          address: 'address',
          shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation),
      isMobile: true,
      serviceRequestStatus: ServiceRequestStatus.idle,
    ),
  ]);
}
