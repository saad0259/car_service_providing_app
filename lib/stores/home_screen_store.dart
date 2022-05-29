import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../custom_utils/function_response.dart';
import '../custom_utils/google_maps_helper.dart';
import '../models/service_shop.dart';

import '../service_locator.dart';
import '../stores/profile_store.dart';
part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStore with _$HomeScreenStore;

abstract class _HomeScreenStore with Store {
  _HomeScreenStore(this._profileStore);

  final ProfileStore _profileStore;

  @observable
  bool isLoadingHomeScreenData = false;

  @observable
  ServiceShop currentUser = ServiceShop(
    id: '',
    name: '',
    email: '',
    cnic: '',
    password: '',
    address: '',
    phone: '',
    openingTime: TimeOfDay.now(),
    closingTime: TimeOfDay.now(),
    coverImage: '',
    rating: 0,
    shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  void updateIsLoadingHomeScreenData(bool newValue) {
    isLoadingHomeScreenData = newValue;
  }

  @action
  Future<void> loadAllData() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    updateIsLoadingHomeScreenData(true);
    fResponse = await _profileStore.loadProfile();
    fResponse.printResponse();
    if (fResponse.success) {
      currentUser = _profileStore.currentUser!;
      print('name : ${currentUser.name}');
      print('location : ${currentUser.shopLocation.toString()}');
    }

    updateIsLoadingHomeScreenData(false);
  }
}
