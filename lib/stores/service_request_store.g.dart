// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServiceRequestStore on _ServiceRequestStore, Store {
  late final _$isLoadingOrdersAtom =
      Atom(name: '_ServiceRequestStore.isLoadingOrders', context: context);

  @override
  bool get isLoadingOrders {
    _$isLoadingOrdersAtom.reportRead();
    return super.isLoadingOrders;
  }

  @override
  set isLoadingOrders(bool value) {
    _$isLoadingOrdersAtom.reportWrite(value, super.isLoadingOrders, () {
      super.isLoadingOrders = value;
    });
  }

  late final _$serviceRequestListAtom =
      Atom(name: '_ServiceRequestStore.serviceRequestList', context: context);

  @override
  ObservableList<ServiceRequest> get serviceRequestList {
    _$serviceRequestListAtom.reportRead();
    return super.serviceRequestList;
  }

  @override
  set serviceRequestList(ObservableList<ServiceRequest> value) {
    _$serviceRequestListAtom.reportWrite(value, super.serviceRequestList, () {
      super.serviceRequestList = value;
    });
  }

  late final _$loadAllServiceRequestsAsyncAction = AsyncAction(
      '_ServiceRequestStore.loadAllServiceRequests',
      context: context);

  @override
  Future<void> loadAllServiceRequests() {
    return _$loadAllServiceRequestsAsyncAction
        .run(() => super.loadAllServiceRequests());
  }

  @override
  String toString() {
    return '''
isLoadingOrders: ${isLoadingOrders},
serviceRequestList: ${serviceRequestList}
    ''';
  }
}
