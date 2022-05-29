import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../custom_utils/google_maps_helper.dart';
import '../constants/firebase_constants.dart';
import '../custom_utils/function_response.dart';
import '../custom_utils/image_helper.dart';
import '../models/service_shop.dart';
import '../service_locator.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  _AuthStore(this._customImageHelper);

  final CustomImageHelper _customImageHelper;

  @observable
  ServiceShop newServiceShop = ServiceShop(
    id: '',
    name: '',
    cnic: '',
    email: '',
    password: '',
    address: '',
    phone: '',
    // openingTime: TimeOfDay.now(),
    // closingTime: TimeOfDay.now(),
    coverImage: '',
    rating: 0,
    shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
  );

  // @observable
  // ServiceShop? currentUser;
  // @observable
  // ObservableList<ServiceShop> serviceShopeList =
  //     ObservableList<ServiceShop>.of([]);

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
      // openingTime: newServiceShop.openingTime,
      // closingTime: newServiceShop.closingTime,
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
      // openingTime: newServiceShop.openingTime,
      // closingTime: newServiceShop.closingTime,
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
      // openingTime: newServiceShop.openingTime,
      // closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: location,
    );
    print('store updated location : $location');
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
      // openingTime: newServiceShop.openingTime,
      // closingTime: newServiceShop.closingTime,
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
      // openingTime: newServiceShop.openingTime,
      // closingTime: newServiceShop.closingTime,
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
      // openingTime: newServiceShop.openingTime,
      // closingTime: newServiceShop.closingTime,
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
      // openingTime: newServiceShop.openingTime,
      // closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: newServiceShop.shopLocation,
    );
  }

  @action
  void updateAddress(String newAddress) {
    newServiceShop = ServiceShop(
      id: newServiceShop.id,
      name: newServiceShop.name,
      cnic: newServiceShop.cnic,
      email: newServiceShop.email,
      password: newServiceShop.password,
      address: newAddress,
      phone: newServiceShop.phone,
      // openingTime: newServiceShop.openingTime,
      // closingTime: newServiceShop.closingTime,
      coverImage: newServiceShop.coverImage,
      rating: newServiceShop.rating,
      shopLocation: newServiceShop.shopLocation,
    );
  }

  void resetSignupForm() {
    newServiceShop = ServiceShop(
      id: '',
      name: '',
      cnic: '',
      email: '',
      password: '',
      address: '',
      phone: '',
      // openingTime: TimeOfDay.now(),
      // closingTime: TimeOfDay.now(),
      coverImage: '',
      rating: 0,
      shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
    );
  }

  Future<FunctionResponse> trySignup() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      fResponse = await checkIsCnicDuplicated(newServiceShop.cnic);
      fResponse.printResponse();
      if (fResponse.success && !fResponse.data) {
        final UserCredential _authResult =
            await firebaseAuth.createUserWithEmailAndPassword(
                email: newServiceShop.email, password: newServiceShop.password);
        if (_authResult.user != null) {
          fResponse = await _customImageHelper.uploadPicture(
              (newServiceShop.coverImage), serviceShopImagesDirectory);
          if (fResponse.success) {
            updateCoverImage(fResponse.data);

            await firestoreShopsCollection.doc(_authResult.user!.uid).set({
              'name': newServiceShop.name,
              'email': newServiceShop.email,
              'password': newServiceShop.password,
              'coverImage': newServiceShop.coverImage,
              'rating': newServiceShop.rating,
              'cnic': newServiceShop.cnic,
              'address': newServiceShop.address,
              'phone': newServiceShop.phone,
              'shopLocation': GeoPoint(newServiceShop.shopLocation.latitude,
                  newServiceShop.shopLocation.longitude),
              'createdAt': DateTime.now().toIso8601String(),
            });
            fResponse.passed(message: 'Signup Successfull');
          }
        } else {
          fResponse.failed(message: 'Error Signing Up');
        }
      } else {
        fResponse.failed(
            message: fResponse.data == null
                ? 'Cnic check failed'
                : 'Cnic Already Exists');
      }
    } catch (e) {
      fResponse.failed(message: 'Error signing up : $e');
    }

    resetSignupForm();

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

  Future<FunctionResponse> checkIsCnicDuplicated(String cnic) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    try {
      final QuerySnapshot? data =
          await firestoreShopsCollection.where('cnic', isEqualTo: cnic).get();
      if (data != null && data.docs.isNotEmpty) {
        fResponse.data = true;
      } else {
        fResponse.data = false;
      }
      fResponse.passed(message: 'cnic check successfull : ${fResponse.data}');
    } catch (e) {
      fResponse.failed(message: 'Error during checkCnicDuplication  : e');
    }
    return fResponse;
  }
}
