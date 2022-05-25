// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  late final _$newServiceShopAtom =
      Atom(name: '_AuthStore.newServiceShop', context: context);

  @override
  ServiceShop get newServiceShop {
    _$newServiceShopAtom.reportRead();
    return super.newServiceShop;
  }

  @override
  set newServiceShop(ServiceShop value) {
    _$newServiceShopAtom.reportWrite(value, super.newServiceShop, () {
      super.newServiceShop = value;
    });
  }

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  void updateCoverImage(String image) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateCoverImage');
    try {
      return super.updateCoverImage(image);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateName(String name) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.updateName');
    try {
      return super.updateName(name);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateLocation(LatLng location) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateLocation');
    try {
      return super.updateLocation(location);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateEmail(String email) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateEmail');
    try {
      return super.updateEmail(email);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePassword(String password) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updatePassword');
    try {
      return super.updatePassword(password);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePhone(String newphone) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updatePhone');
    try {
      return super.updatePhone(newphone);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCnic(String newCnic) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.updateCnic');
    try {
      return super.updateCnic(newCnic);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateAddress(String newAddress) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.updateAddress');
    try {
      return super.updateAddress(newAddress);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newServiceShop: ${newServiceShop}
    ''';
  }
}
