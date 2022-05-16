// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceRequestStore on _ServiceRequestStore, Store {
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

  @override
  String toString() {
    return '''
serviceRequestList: ${serviceRequestList}
    ''';
  }
}
