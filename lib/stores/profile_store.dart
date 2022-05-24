import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../custom_utils/function_response.dart';
import '../custom_utils/google_maps_helper.dart';
import '../models/service_shop.dart';
import '../resources/app_images.dart';
import '../service_locator.dart';
import 'auth_store.dart';
import 'manage_service_store.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  _ProfileStore(this._manageServiceStore, this._authStore);
  final ManageServiceStore _manageServiceStore;
  final AuthStore _authStore;

  @observable
  String shopCoverImage = '';
  @observable
  LatLng shopLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
  @observable
  String shopAddress = '';
  @observable
  ServiceShop? currentUser;

  @action
  void getUser() {
    currentUser = _authStore.currentUser;
    print('name : ${currentUser?.name}');
  }

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
      if (currentUser != null) {
        currentUser = ServiceShop(
          id: currentUser!.id,
          name: name,
          cnic: currentUser!.cnic,
          email: currentUser!.email,
          password: currentUser!.password,
          address: currentUser!.address,
          phone: currentUser!.phone,
          openingTime: currentUser!.openingTime,
          closingTime: currentUser!.closingTime,
          coverImage: shopCoverImage,
          rating: currentUser!.rating,
          shopLocation: currentUser!.shopLocation,
        );
        fResponse.passed(message: 'Updated Profile');
      }
    } catch (e) {
      fResponse.failed(message: 'Unable to update profile : $e');
    }
    return fResponse;
  }
}
