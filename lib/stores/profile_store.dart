import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../constants/firebase_constants.dart';
import '../custom_utils/function_response.dart';
import '../custom_utils/google_maps_helper.dart';
import '../custom_utils/image_helper.dart';
import '../models/service_shop.dart';
import '../resources/app_images.dart';
import '../service_locator.dart';
import 'auth_store.dart';
import 'manage_service_store.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  _ProfileStore(this._authStore, this._customImageHelper);
  final AuthStore _authStore;
  final CustomImageHelper _customImageHelper;
  bool isLoading = false;

  @observable
  String shopCoverImage = '';
  @observable
  LatLng shopLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
  @observable
  String shopAddress = '';
  @observable
  ServiceShop currentUser = ServiceShop(
    id: '',
    name: '',
    email: '',
    cnic: '',
    password: '',
    address: '',
    phone: '',
    // openingTime: TimeOfDay.now(),
    // closingTime: TimeOfDay.now(),
    coverImage: '',
    rating: 0,
    shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  @action
  void updateCurrentUser(ServiceShop serviceShop) {
    currentUser = serviceShop;
  }

  void toggleIsLoading() {
    isLoading = isLoading;
  }

  @action
  Future<FunctionResponse> loadProfile() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    toggleIsLoading();
    try {
      var data;
      final User? user = firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot doc =
            await firestoreShopsCollection.doc(user.uid).get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          print(' Data from FireBase ${data.toString()}');
          LatLng shopLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
          final GeoPoint dbLocation = data['shopLocation'] as GeoPoint;
          shopLocation = LatLng(dbLocation.latitude, dbLocation.longitude);
          log('new shop Location ${shopLocation.longitude}');

          print('after getting location');
          currentUser = ServiceShop(
            id: user.uid,
            name: data['name'],
            email: data['email'],
            password: data['password'],
            address: data['address'],
            cnic: data['cnic'] ?? '',
            phone: data['phone'],
            // openingTime: data['openingTime'] ?? TimeOfDay.now(),
            // closingTime: data['closingTime'] ?? TimeOfDay.now(),
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
    toggleIsLoading();

    return fResponse;
  }

  @action
  Future<FunctionResponse> updateProfile() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    try {
      final User? user = firebaseAuth.currentUser;
      if (user != null) {
        if ((_customImageHelper.getImageType(currentUser.coverImage)) ==
            ImageType.network) {
          fResponse.passed();
        } else {
          fResponse = await _customImageHelper.uploadPicture(
              (currentUser.coverImage), serviceShopImagesDirectory);
          updateCoverImage(fResponse.data);
        }
        log('before call');
        log('before upload');
        log('new name : ${currentUser.name}');
        log('new phone : ${currentUser.phone}');
        log('new address : ${currentUser.address}');
        log('new location : ${currentUser.shopLocation.latitude.toStringAsFixed(4)} ${currentUser.shopLocation.longitude.toStringAsFixed(4)}');
        if (fResponse.success) {
          log(currentUser.toString());

          WriteBatch batch = firebaseFirestore.batch();
          await firestoreShopsCollection.doc(user.uid).update({
            'name': currentUser.name,
            'address': currentUser.address,
            'coverImage': currentUser.coverImage,
            'shopLocation': GeoPoint(currentUser.shopLocation.latitude,
                currentUser.shopLocation.longitude),
          });
          DocumentReference services =
              await firestoreOrdersCollection.doc('shopId');
          batch.update(services, {
            'shopLocation': GeoPoint(currentUser.shopLocation.latitude,
                currentUser.shopLocation.longitude)
          });
          // Commit the batch
          batch.commit().then((_) {
            // ...
          });
          fResponse.passed(message: 'Profile Updated');
        }
      } else {
        fResponse.failed(message: 'Current user not found');
      }
    } catch (e) {
      fResponse.failed(message: 'Error updating profile : $e');
    }

    return fResponse;
  }

  @action
  void updateName(String newName) {
    currentUser = ServiceShop(
      id: currentUser.id,
      name: newName,
      cnic: currentUser.cnic,
      email: currentUser.email,
      password: currentUser.password,
      address: currentUser.address,
      phone: currentUser.phone,
      // openingTime: currentUser.openingTime,
      // closingTime: currentUser.closingTime,
      coverImage: currentUser.coverImage,
      rating: currentUser.rating,
      shopLocation: currentUser.shopLocation,
    );
  }

  @action
  void updatePhone(String newPhone) {
    currentUser = ServiceShop(
      id: currentUser.id,
      name: currentUser.name,
      cnic: currentUser.cnic,
      email: currentUser.email,
      password: currentUser.password,
      address: currentUser.address,
      phone: newPhone,
      // openingTime: currentUser.openingTime,
      // closingTime: currentUser.closingTime,
      coverImage: currentUser.coverImage,
      rating: currentUser.rating,
      shopLocation: currentUser.shopLocation,
    );
  }

  @action
  void updateLocation(LatLng newLocation) {
    currentUser = ServiceShop(
      id: currentUser.id,
      name: currentUser.name,
      cnic: currentUser.cnic,
      email: currentUser.email,
      password: currentUser.password,
      address: currentUser.address,
      phone: currentUser.phone,
      // openingTime: currentUser.openingTime,
      // closingTime: currentUser.closingTime,
      coverImage: currentUser.coverImage,
      rating: currentUser.rating,
      shopLocation: newLocation,
    );
  }

  @action
  void updateCoverImage(String newImage) {
    currentUser = ServiceShop(
      id: currentUser.id,
      name: currentUser.name,
      cnic: currentUser.cnic,
      email: currentUser.email,
      password: currentUser.password,
      address: currentUser.address,
      phone: currentUser.phone,
      // openingTime: currentUser.openingTime,
      // closingTime: currentUser.closingTime,
      coverImage: newImage,
      rating: currentUser.rating,
      shopLocation: currentUser.shopLocation,
    );
  }

  @action
  void updateAddress(String newAddress) {
    currentUser = ServiceShop(
      id: currentUser.id,
      name: currentUser.name,
      cnic: currentUser.cnic,
      email: currentUser.email,
      password: currentUser.password,
      address: newAddress,
      phone: currentUser.phone,
      // openingTime: currentUser.openingTime,
      // closingTime: currentUser.closingTime,
      coverImage: currentUser.coverImage,
      rating: currentUser.rating,
      shopLocation: currentUser.shopLocation,
    );
  }

  // @action
  // FunctionResponse updateProfile(String name) {
  //   FunctionResponse fResponse = getIt<FunctionResponse>();
  //   try {
  //     serviceShop = ServiceShop(
  //       id: serviceShop.id,
  //       name: name,
  //       email: serviceShop.email,
  //       password: serviceShop.password,
  //       address: serviceShop.address,
  //       phone: serviceShop.phone,
  //       openingTime: serviceShop.openingTime,
  //       closingTime: serviceShop.closingTime,
  //       coverImage: shopCoverImage,
  //       rating: serviceShop.rating,
  //       shopLocation: serviceShop.shopLocation,
  //     );
  //     fResponse.passed(message: 'Updated Profile');
  //   } catch (e) {
  //     fResponse.failed(message: 'Unable to update profile : $e');
  //   }
  //   return fResponse;
  // }
}
