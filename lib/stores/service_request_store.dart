import 'package:mobx/mobx.dart';

import '../models/service_request.dart';
import '../models/vehicle.dart';

part 'service_request_store.g.dart';

class ServiceRequestStore = _ServiceRequestStore with _$ServiceRequestStore;

abstract class _ServiceRequestStore with Store {
  @observable
  ObservableList<ServiceRequest> serviceRequestList =
      ObservableList<ServiceRequest>.of([]);
}
