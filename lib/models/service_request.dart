import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'vehicle_service.dart';

class ServiceRequest {
  String id;
  String userId;
  String shopId;
  PaymentMethod paymentMethod;
  DateTime dateTime;
  VehicleService vehicleService;
  bool isMobile;
  ServiceRequestStatus serviceRequestStatus;
  LatLng userLocation;
  LatLng shopLocation;

  ServiceRequest({
    required this.id,
    required this.userId,
    required this.shopId,
    required this.paymentMethod,
    required this.dateTime,
    required this.vehicleService,
    required this.isMobile,
    required this.serviceRequestStatus,
    required this.userLocation,
    required this.shopLocation,
  });
}

enum PaymentMethod {
  cash,
  jazzcash,
}

extension PaymentMethodName on PaymentMethod {
  String getName() {
    String name = 'Undefined';
    switch (this) {
      case PaymentMethod.cash:
        name = 'Cash';
        break;
      case PaymentMethod.jazzcash:
        name = 'JazzCash';
        break;

      default:
        break;
    }
    return name;
  }
}

PaymentMethod getPaymentMethodByName(String name) {
  PaymentMethod paymentMethod = PaymentMethod.cash;

  switch (name) {
    case 'Cash':
      paymentMethod = PaymentMethod.cash;
      break;
    case 'JazzCash':
      paymentMethod = PaymentMethod.jazzcash;
      break;

    default:
      break;
  }
  return paymentMethod;
}

enum ServiceRequestStatus {
  idle,
  inprogress,
  completed,
  canceled,
  done,
}

extension ServiceRequestStatusName on ServiceRequestStatus {
  String getName() {
    String name = 'Undefined';
    switch (this) {
      case ServiceRequestStatus.canceled:
        name = 'Canceled';
        break;
      case ServiceRequestStatus.completed:
        name = 'Completed';
        break;
      case ServiceRequestStatus.done:
        name = 'Done';
        break;
      case ServiceRequestStatus.idle:
        name = 'Idle';
        break;
      case ServiceRequestStatus.inprogress:
        name = 'In Progress';
        break;

      default:
        break;
    }
    return name;
  }
}

ServiceRequestStatus getServiceRequestStatusByName(String name) {
  ServiceRequestStatus serviceRequestStatus = ServiceRequestStatus.idle;

  switch (name) {
    case 'Canceled':
      serviceRequestStatus = ServiceRequestStatus.canceled;
      break;
    case 'Completed':
      serviceRequestStatus = ServiceRequestStatus.completed;
      break;
    case 'Done':
      serviceRequestStatus = ServiceRequestStatus.done;
      break;
    case 'Idle':
      serviceRequestStatus = ServiceRequestStatus.idle;
      break;
    case 'In Progress':
      serviceRequestStatus = ServiceRequestStatus.inprogress;
      break;

    default:
      break;
  }
  return serviceRequestStatus;
}
