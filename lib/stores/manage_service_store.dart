import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../custom_utils/function_response.dart';
import '../custom_utils/general_helper.dart';
import '../custom_utils/google_maps_helper.dart';
import '../models/vehicle.dart';
import '../models/vehicle_service.dart';
import '../resources/app_images.dart';
import '../service_locator.dart';
import 'home_screen_store.dart';
import 'profile_store.dart';

part 'manage_service_store.g.dart';

class ManageServiceStore = _ManageServiceStore with _$ManageServiceStore;

abstract class _ManageServiceStore with Store {
  @observable
  VehicleService newVehicleService = VehicleService(
    id: '',
    shopId: '',
    coverImage: '',
    shopName: '',
    serviceName: '',
    description: '',
    serviceType: ServiceType.fullCarWash,
    vehicleType: VehicleType.bike,
    rating: 1,
    cost: 1,
    address: '',
    shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
  );
  @observable
  ObservableList<VehicleService> vehicleServiceList =
      ObservableList<VehicleService>.of([
    VehicleService(
      id: '1234',
      shopId: '123',
      coverImage: fullCarServiceImage,
      shopName: 'Abc',
      serviceName: 'Car Service',
      description: 'Hello Hi',
      serviceType: ServiceType.carService,
      vehicleType: VehicleType.bike,
      rating: 4.1,
      cost: 100,
      address: 'some address ',
      shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
    ),
  ]);
  @action
  void changeSelectedVehicleType(String newVehicleType) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newVehicleService.description,
      serviceType: newVehicleService.serviceType,
      vehicleType: getVehicleTypeFromVehicleName(newVehicleType),
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeDescription(String newDescription) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newDescription,
      serviceType: newVehicleService.serviceType,
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeCost(double newCost) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newVehicleService.description,
      serviceType: newVehicleService.serviceType,
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newCost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeServiceName(String newServiceName) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newServiceName,
      description: newVehicleService.description,
      serviceType: newVehicleService.serviceType,
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeCoverImage(String newImage) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newVehicleService.description,
      serviceType: newVehicleService.serviceType,
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeSelectedServiceType(String newServiceType) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newVehicleService.description,
      serviceType: getServiceTypeFromServiceName(newServiceType),
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  Future<FunctionResponse> addNewService(String shopId, String shopName,
      double rating, String address, LatLng shopLocation) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      await delayFunction();
      newVehicleService = VehicleService(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        shopId: shopId,
        coverImage: newVehicleService.coverImage,
        shopName: shopName,
        serviceName: newVehicleService.serviceName,
        description: newVehicleService.description,
        serviceType: newVehicleService.serviceType,
        vehicleType: newVehicleService.vehicleType,
        rating: rating,
        cost: newVehicleService.cost,
        address: address,
        shopLocation: shopLocation,
      );
      vehicleServiceList.add(newVehicleService);
      fResponse.passed(message: 'Added new service');
    } catch (e) {
      fResponse.failed(message: 'Error adding new service : $e');
    }
    return fResponse;
  }

  @action
  void updateServiceLocations(LatLng newLocation) {
    for (var element in vehicleServiceList) {
      element.shopLocation = newLocation;
    }
  }
}
