import 'package:car_service_providing_app/custom_utils/google_maps_helper.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../custom_utils/function_response.dart';
import '../models/service_shop.dart';
import '../service_locator.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  ServiceShop newServiceShop = ServiceShop(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    openingTime: TimeOfDay.now(),
    closingTime: TimeOfDay.now(),
    coverImage: '',
    rating: 0,
    shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  @observable
  ServiceShop? currentUser;
  @observable
  ObservableList<ServiceShop> serviceShopeList =
      ObservableList<ServiceShop>.of([]);

  @action
  void updateCoverImage(String image) {
    newServiceShop = ServiceShop(
      id: newServiceShop.id,
      name: newServiceShop.name,
      email: newServiceShop.email,
      password: newServiceShop.password,
      address: newServiceShop.address,
      openingTime: newServiceShop.openingTime,
      closingTime: newServiceShop.closingTime,
      coverImage: image,
      rating: newServiceShop.rating,
      shopLocation: newServiceShop.shopLocation,
    );
  }

  @action
  void updateName(String name) {
    newServiceShop = ServiceShop(
      id: newServiceShop.id,
      name: name,
      email: newServiceShop.email,
      password: newServiceShop.password,
      address: newServiceShop.address,
      openingTime: newServiceShop.openingTime,
      closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: newServiceShop.shopLocation,
    );
  }

  @action
  void updateEmail(String email) {
    newServiceShop = ServiceShop(
      id: newServiceShop.id,
      name: newServiceShop.name,
      email: email,
      password: newServiceShop.password,
      address: newServiceShop.address,
      openingTime: newServiceShop.openingTime,
      closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: newServiceShop.shopLocation,
    );
  }

  @action
  void updatePassword(String password) {
    newServiceShop = ServiceShop(
      id: newServiceShop.id,
      name: newServiceShop.name,
      email: newServiceShop.email,
      password: password,
      address: newServiceShop.address,
      openingTime: newServiceShop.openingTime,
      closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: newServiceShop.shopLocation,
    );
  }

  FunctionResponse trySignup() {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    serviceShopeList.add(newServiceShop);
    currentUser = newServiceShop;
    print('auth name : ${currentUser?.name}');
    fResponse.passed(message: 'SignUp Successfull');
    newServiceShop = ServiceShop(
      id: '',
      name: '',
      email: '',
      password: '',
      address: '',
      openingTime: TimeOfDay.now(),
      closingTime: TimeOfDay.now(),
      coverImage: '',
      rating: 0,
      shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
    );

    return fResponse;
  }

  FunctionResponse tryLogin(String email, String password) {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    currentUser = serviceShopeList.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: null);
    if (currentUser != null) {
      fResponse.passed(message: 'Login Successfull');
    } else {
      fResponse.failed(message: 'Credentials do not match');
    }

    return fResponse;
  }
}
