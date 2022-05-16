// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_service_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ManageServiceStore on _ManageServiceStore, Store {
  late final _$newVehicleServiceAtom =
      Atom(name: '_ManageServiceStore.newVehicleService', context: context);

  @override
  VehicleService get newVehicleService {
    _$newVehicleServiceAtom.reportRead();
    return super.newVehicleService;
  }

  @override
  set newVehicleService(VehicleService value) {
    _$newVehicleServiceAtom.reportWrite(value, super.newVehicleService, () {
      super.newVehicleService = value;
    });
  }

  late final _$vehicleServiceListAtom =
      Atom(name: '_ManageServiceStore.vehicleServiceList', context: context);

  @override
  ObservableList<VehicleService> get vehicleServiceList {
    _$vehicleServiceListAtom.reportRead();
    return super.vehicleServiceList;
  }

  @override
  set vehicleServiceList(ObservableList<VehicleService> value) {
    _$vehicleServiceListAtom.reportWrite(value, super.vehicleServiceList, () {
      super.vehicleServiceList = value;
    });
  }

  late final _$addNewServiceAsyncAction =
      AsyncAction('_ManageServiceStore.addNewService', context: context);

  @override
  Future<FunctionResponse> addNewService(String shopId, String shopName,
      double rating, String address, LatLng shopLocation) {
    return _$addNewServiceAsyncAction.run(() =>
        super.addNewService(shopId, shopName, rating, address, shopLocation));
  }

  late final _$_ManageServiceStoreActionController =
      ActionController(name: '_ManageServiceStore', context: context);

  @override
  void changeSelectedVehicleType(String newVehicleType) {
    final _$actionInfo = _$_ManageServiceStoreActionController.startAction(
        name: '_ManageServiceStore.changeSelectedVehicleType');
    try {
      return super.changeSelectedVehicleType(newVehicleType);
    } finally {
      _$_ManageServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDescription(String newDescription) {
    final _$actionInfo = _$_ManageServiceStoreActionController.startAction(
        name: '_ManageServiceStore.changeDescription');
    try {
      return super.changeDescription(newDescription);
    } finally {
      _$_ManageServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCost(double newCost) {
    final _$actionInfo = _$_ManageServiceStoreActionController.startAction(
        name: '_ManageServiceStore.changeCost');
    try {
      return super.changeCost(newCost);
    } finally {
      _$_ManageServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeServiceName(String newServiceName) {
    final _$actionInfo = _$_ManageServiceStoreActionController.startAction(
        name: '_ManageServiceStore.changeServiceName');
    try {
      return super.changeServiceName(newServiceName);
    } finally {
      _$_ManageServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCoverImage(String newImage) {
    final _$actionInfo = _$_ManageServiceStoreActionController.startAction(
        name: '_ManageServiceStore.changeCoverImage');
    try {
      return super.changeCoverImage(newImage);
    } finally {
      _$_ManageServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedServiceType(String newServiceType) {
    final _$actionInfo = _$_ManageServiceStoreActionController.startAction(
        name: '_ManageServiceStore.changeSelectedServiceType');
    try {
      return super.changeSelectedServiceType(newServiceType);
    } finally {
      _$_ManageServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateServiceLocations(LatLng newLocation) {
    final _$actionInfo = _$_ManageServiceStoreActionController.startAction(
        name: '_ManageServiceStore.updateServiceLocations');
    try {
      return super.updateServiceLocations(newLocation);
    } finally {
      _$_ManageServiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newVehicleService: ${newVehicleService},
vehicleServiceList: ${vehicleServiceList}
    ''';
  }
}
