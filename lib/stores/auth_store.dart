import 'package:car_service_providing_app/custom_utils/google_maps_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../constants/firebase_constants.dart';
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
    cnic: '',
    email: '',
    password: '',
    address: '',
    phone: '',
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
      cnic: newServiceShop.cnic,
      email: newServiceShop.email,
      password: newServiceShop.password,
      address: newServiceShop.address,
      phone: newServiceShop.phone,
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
      cnic: newServiceShop.cnic,
      email: newServiceShop.email,
      password: newServiceShop.password,
      address: newServiceShop.address,
      phone: newServiceShop.phone,
      openingTime: newServiceShop.openingTime,
      closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: newServiceShop.shopLocation,
    );
  }

  @action
  void updateLocation(LatLng location) {
    newServiceShop = ServiceShop(
      id: newServiceShop.id,
      name: newServiceShop.name,
      cnic: newServiceShop.cnic,
      email: newServiceShop.email,
      password: newServiceShop.password,
      address: newServiceShop.address,
      phone: newServiceShop.phone,
      openingTime: newServiceShop.openingTime,
      closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: location,
    );
  }

  @action
  void updateEmail(String email) {
    newServiceShop = ServiceShop(
      id: newServiceShop.id,
      name: newServiceShop.name,
      cnic: newServiceShop.cnic,
      email: email,
      password: newServiceShop.password,
      address: newServiceShop.address,
      phone: newServiceShop.phone,
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
      cnic: newServiceShop.cnic,
      email: newServiceShop.email,
      password: password,
      address: newServiceShop.address,
      phone: newServiceShop.phone,
      openingTime: newServiceShop.openingTime,
      closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: newServiceShop.shopLocation,
    );
  }

  @action
  void updatePhone(String newphone) {
    newServiceShop = ServiceShop(
      id: newServiceShop.id,
      name: newServiceShop.name,
      cnic: newServiceShop.cnic,
      email: newServiceShop.email,
      password: newServiceShop.password,
      address: newServiceShop.address,
      phone: newphone,
      openingTime: newServiceShop.openingTime,
      closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: newServiceShop.shopLocation,
    );
  }

  @action
  void updateCnic(String newCnic) {
    newServiceShop = ServiceShop(
      id: newServiceShop.id,
      name: newServiceShop.name,
      cnic: newCnic,
      email: newServiceShop.email,
      password: newServiceShop.password,
      address: newServiceShop.address,
      phone: newServiceShop.phone,
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
      cnic: '',
      email: '',
      password: '',
      address: '',
      phone: '',
      openingTime: TimeOfDay.now(),
      closingTime: TimeOfDay.now(),
      coverImage: '',
      rating: 0,
      shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
    );

    return fResponse;
  }

  Future<FunctionResponse> tryLogin(String email, String password) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      fResponse.passed(message: 'Login Successful');
    } on FirebaseAuthException catch (e) {
      fResponse.failed(
          message:
              e.message ?? 'Error occurred, please check your credentials!');
    } catch (e) {
      fResponse.failed(message: 'Error logging in : $e');
    }

    return fResponse;
  }
}
