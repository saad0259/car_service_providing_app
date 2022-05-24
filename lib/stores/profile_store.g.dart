// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  late final _$shopCoverImageAtom =
      Atom(name: '_ProfileStore.shopCoverImage', context: context);

  @override
  String get shopCoverImage {
    _$shopCoverImageAtom.reportRead();
    return super.shopCoverImage;
  }

  @override
  set shopCoverImage(String value) {
    _$shopCoverImageAtom.reportWrite(value, super.shopCoverImage, () {
      super.shopCoverImage = value;
    });
  }

  late final _$shopLocationAtom =
      Atom(name: '_ProfileStore.shopLocation', context: context);

  @override
  LatLng get shopLocation {
    _$shopLocationAtom.reportRead();
    return super.shopLocation;
  }

  @override
  set shopLocation(LatLng value) {
    _$shopLocationAtom.reportWrite(value, super.shopLocation, () {
      super.shopLocation = value;
    });
  }

  late final _$shopAddressAtom =
      Atom(name: '_ProfileStore.shopAddress', context: context);

  @override
  String get shopAddress {
    _$shopAddressAtom.reportRead();
    return super.shopAddress;
  }

  @override
  set shopAddress(String value) {
    _$shopAddressAtom.reportWrite(value, super.shopAddress, () {
      super.shopAddress = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_ProfileStore.currentUser', context: context);

  @override
  ServiceShop? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(ServiceShop? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore', context: context);

  @override
  void getUser() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.getUser');
    try {
      return super.getUser();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeShopCoverImage(String image) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.changeShopCoverImage');
    try {
      return super.changeShopCoverImage(image);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeShopLocation(LatLng location) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.changeShopLocation');
    try {
      return super.changeShopLocation(location);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeShopAddress(String address) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.changeShopAddress');
    try {
      return super.changeShopAddress(address);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  FunctionResponse updateProfile(String name) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateProfile');
    try {
      return super.updateProfile(name);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
shopCoverImage: ${shopCoverImage},
shopLocation: ${shopLocation},
shopAddress: ${shopAddress},
currentUser: ${currentUser}
    ''';
  }
}
