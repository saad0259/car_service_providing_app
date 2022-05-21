import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../constants/firebase_constants.dart';
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

  @observable
  ServiceShop serviceShop = ServiceShop(
    id: '123',
    name: 'Pseudo Name',
    email: 'abc@gmail.com',
    password: '12345678',
    address: 'some address',
    phone: '30123456789',
    openingTime: TimeOfDay.now(),
    closingTime: TimeOfDay.now(),
    coverImage: fullCarServiceImage,
    rating: 3,
    shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  @action
  void getUser() {
    // currentUser = _authStore.currentUser;
    print('name : ${currentUser?.name}');
  }

  @action
  Future<FunctionResponse> loadProfile() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    try {
      var data;
      final User? user = firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await firestoreShops.doc(user.uid).get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          print(' Data from FireBase ${data.toString()}');
          LatLng shopLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
          if (data['shopLocation'] == null) {
            final GeoPoint dbLocation = data['shopLocation'] as GeoPoint;
            shopLocation = LatLng(dbLocation.latitude, dbLocation.longitude);
          }
          print('after getting location');
          currentUser = ServiceShop(
            id: user.uid,
            name: data['name'],
            email: data['email'],
            password: data['password'],
            address: data['address'],
            phone: data['phone'],
            openingTime: data['openingTime'] ?? TimeOfDay.now(),
            closingTime: data['closingTime'] ?? TimeOfDay.now(),
            coverImage: data['coverImage'] ?? '',
            rating: data['rating'] ?? 0,
            shopLocation: shopLocation,
          );
          fResponse.passed(message: 'Profile Loaded from database');
        }
      } else {
        fResponse.failed(message: 'Current user not found');
      }
    } catch (e) {
      fResponse.failed(message: 'Error loading profile : $e');
    }

    return fResponse;
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
      serviceShop = ServiceShop(
        id: serviceShop.id,
        name: name,
        email: serviceShop.email,
        password: serviceShop.password,
        address: serviceShop.address,
        phone: serviceShop.phone,
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
