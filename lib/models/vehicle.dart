import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

extension VehicleTypeIcon on VehicleType {
  Widget getIcon() {
    Widget icon = const Icon(Icons.do_not_disturb);
    switch (this) {
      case VehicleType.bike:
        icon = const Icon(Icons.directions_bike);
        break;

      case VehicleType.suv:
        icon = const FaIcon(FontAwesomeIcons.carSide);
        break;

      case VehicleType.auto:
        icon = const Icon(Icons.electric_rickshaw);
        break;

      case VehicleType.sedan:
        icon = const Icon(Icons.directions_car);
        break;

      case VehicleType.truck:
        icon = const FaIcon(FontAwesomeIcons.truck);
        break;

      case VehicleType.wagon:
        icon = const FaIcon(FontAwesomeIcons.vanShuttle);
        break;

      case VehicleType.bus:
        icon = const Icon(Icons.directions_bus);
        break;

      default:
        break;
    }
    return icon;
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
