import 'package:flutter/material.dart';

class Vehicle {
  String id;
  String vehicleModel;
  String vehicleCompany;
  VehicleType vehicleType;
  String vehicleDescription;
  List<String> vehicleImages;
  Vehicle({
    required this.id,
    required this.vehicleModel,
    required this.vehicleCompany,
    required this.vehicleDescription,
    required this.vehicleType,
    required this.vehicleImages,
  });
}

enum VehicleType {
  bike,
  auto,
  sedan,
  suv,
  bus,
  wagon,
  truck,
}

extension VehicleTypeName on VehicleType {
  String getName() {
    String name = 'Undefined';
    switch (this) {
      case VehicleType.bike:
        name = 'Bike';
        break;

      case VehicleType.suv:
        name = 'SUV';
        break;

      case VehicleType.auto:
        name = 'Auto Rikshaw';
        break;

      case VehicleType.sedan:
        name = 'Sedan';
        break;

      case VehicleType.truck:
        name = 'Truck';
        break;

      case VehicleType.wagon:
        name = 'Wagon';
        break;

      case VehicleType.bus:
        name = 'Bus';
        break;

      default:
        break;
    }
    return name;
  }
}

VehicleType getVehicleTypeFromVehicleName(String name) {
  VehicleType vehicleType = VehicleType.auto;
  switch (name) {
    case 'Bike':
      vehicleType = VehicleType.bike;
      break;

    case 'SUV':
      vehicleType = VehicleType.suv;
      break;

    case 'Auto Rikshaw':
      vehicleType = VehicleType.auto;
      break;

    case 'Sedan':
      vehicleType = VehicleType.sedan;
      break;

    case 'Truck':
      vehicleType = VehicleType.truck;
      break;

    case 'Wagon':
      vehicleType = VehicleType.wagon;
      break;

    case 'Bus':
      vehicleType = VehicleType.bus;
      break;

    default:
      break;
  }

  return vehicleType;
}
