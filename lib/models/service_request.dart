import 'user.dart';
import 'vehicle_service.dart';

class ServiceRequest {
  String id;
  User user;
  PaymentMethod paymentMethod;
  DateTime dateTime;
  VehicleService vehicleService;
  bool isMobile;
  ServiceRequestStatus serviceRequestStatus;

  ServiceRequest({
    required this.id,
    required this.user,
    required this.paymentMethod,
    required this.dateTime,
    required this.vehicleService,
    required this.isMobile,
    required this.serviceRequestStatus,
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
