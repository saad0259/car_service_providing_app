// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

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
  ServiceShop get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(ServiceShop value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$loadProfileAsyncAction =
      AsyncAction('_ProfileStore.loadProfile', context: context);

  @override
  Future<FunctionResponse> loadProfile() {
    return _$loadProfileAsyncAction.run(() => super.loadProfile());
  }

  late final _$updateProfileAsyncAction =
      AsyncAction('_ProfileStore.updateProfile', context: context);

  @override
  Future<FunctionResponse> updateProfile() {
    return _$updateProfileAsyncAction.run(() => super.updateProfile());
  }

  late final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore', context: context);

  @override
  void updateCurrentUser(ServiceShop serviceShop) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateCurrentUser');
    try {
      return super.updateCurrentUser(serviceShop);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateName(String newName) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateName');
    try {
      return super.updateName(newName);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePhone(String newPhone) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updatePhone');
    try {
      return super.updatePhone(newPhone);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateLocation(LatLng newLocation) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateLocation');
    try {
      return super.updateLocation(newLocation);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCoverImage(String newImage) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateCoverImage');
    try {
      return super.updateCoverImage(newImage);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateAddress(String newAddress) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.updateAddress');
    try {
      return super.updateAddress(newAddress);
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
