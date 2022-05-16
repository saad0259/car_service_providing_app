import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'vehicle.dart' show VehicleType;

class VehicleService {
  String id;
  String coverImage;
  String shopName;
  String shopId;
  String serviceName;
  String description;
  ServiceType serviceType;
  VehicleType vehicleType;
  double rating;
  double cost;
  String address;
  LatLng shopLocation;
  VehicleService({
    required this.id,
    required this.shopId,
    required this.coverImage,
    required this.shopName,
    required this.serviceName,
    required this.description,
    required this.serviceType,
    required this.vehicleType,
    required this.rating,
    required this.cost,
    required this.address,
    required this.shopLocation,
  });
}

enum ServiceType {
  halfCarWash,
  fullCarWash,
  oilChange,
  breakService,
  carService,
  batteryIssue,
  tyreChange,
  tyreRepair,
}

extension ServiceTypeName on ServiceType {
  String getName() {
    String name = 'Undefined';
    switch (this) {
      case ServiceType.fullCarWash:
        name = 'Full Car Wash';
        break;
      case ServiceType.batteryIssue:
        name = 'Battery Issue';
        break;
      case ServiceType.halfCarWash:
        name = 'Half Car Wash';
        break;
      case ServiceType.oilChange:
        name = 'Oil Change';
        break;
      case ServiceType.breakService:
        name = 'Break Service';
        break;
      case ServiceType.carService:
        name = 'Car Service';
        break;
      case ServiceType.tyreChange:
        name = 'Tyre Change';
        break;
      case ServiceType.tyreRepair:
        name = 'Tyre Repair';
        break;

      default:
        break;
    }
    return name;
  }
}

ServiceType getServiceTypeFromServiceName(String name) {
  ServiceType serviceType = ServiceType.fullCarWash;
  switch (name) {
    case 'Full Car Wash':
      serviceType = ServiceType.fullCarWash;
      break;
    case 'Battery Issue':
      serviceType = ServiceType.batteryIssue;
      break;
    case 'Half Car Wash':
      serviceType = ServiceType.halfCarWash;
      break;
    case 'Oil Change':
      serviceType = ServiceType.oilChange;
      break;
    case 'Break Service':
      serviceType = ServiceType.breakService;
      break;
    case 'Car Service':
      serviceType = ServiceType.carService;
      break;
    case 'Tyre Change':
      serviceType = ServiceType.tyreChange;
      break;
    case 'Tyre Repair':
      serviceType = ServiceType.tyreRepair;
      break;

    default:
      break;
  }

  return serviceType;
}
