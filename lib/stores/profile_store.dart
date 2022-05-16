import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../custom_utils/function_response.dart';
import '../custom_utils/google_maps_helper.dart';
import '../models/service_shop.dart';
import '../resources/app_images.dart';
import '../service_locator.dart';
import 'manage_service_store.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  _ProfileStore(this._manageServiceStore);
  final ManageServiceStore _manageServiceStore;

  @observable
  String shopCoverImage = '';
  @observable
  LatLng shopLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
  @observable
  String shopAddress = '';

  @observable
  ServiceShop serviceShop = ServiceShop(
    id: '123',
    name: 'Pseudo Name',
    address: 'some address',
    openingTime: TimeOfDay.now(),
    closingTime: TimeOfDay.now(),
    coverImage: fullCarServiceImage,
    rating: 3,
    shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  @action
  void changeShopCoverImage(String image) {
    shopCoverImage = image;
  }

  @action
  void changeShopLocation(LatLng location) {
    shopLocation = location;
  }

  @action
  void changeShopAddress(String address) {
    shopAddress = address;
  }

  @action
  FunctionResponse updateProfile(String name) {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    try {
      serviceShop = ServiceShop(
        id: serviceShop.id,
        name: name,
        address: serviceShop.address,
        openingTime: serviceShop.openingTime,
        closingTime: serviceShop.closingTime,
        coverImage: shopCoverImage,
        rating: serviceShop.rating,
        shopLocation: serviceShop.shopLocation,
      );
      fResponse.passed(message: 'Updated Profile');
    } catch (e) {
      fResponse.failed(message: 'Unable to update profile : $e');
    }
    return fResponse;
  }
}