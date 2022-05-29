import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../constants/firebase_constants.dart';
import '../custom_utils/function_response.dart';
import '../custom_utils/general_helper.dart';
import '../custom_utils/google_maps_helper.dart';
import '../custom_utils/image_helper.dart';
import '../models/service_shop.dart';
import '../models/vehicle.dart';
import '../models/vehicle_service.dart';
import '../resources/app_images.dart';
import '../service_locator.dart';
import 'home_screen_store.dart';
import 'profile_store.dart';

part 'manage_service_store.g.dart';

class ManageServiceStore = _ManageServiceStore with _$ManageServiceStore;

abstract class _ManageServiceStore with Store {
  _ManageServiceStore(this._profileStore, this._customImageHelper);
  final ProfileStore _profileStore;
  final CustomImageHelper _customImageHelper;

  @observable
  bool isLoadingAllServices = false;

  @observable
  VehicleService newVehicleService = VehicleService(
    id: '',
    shopId: '',
    coverImage: '',
    shopName: '',
    serviceName: '',
    description: '',
    serviceType: ServiceType.fullCarWash,
    vehicleType: VehicleType.bike,
    rating: 1,
    cost: 1,
    address: '',
    shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
  );
  @observable
  ObservableList<VehicleService> vehicleServiceList =
      ObservableList<VehicleService>.of([
    // VehicleService(
    //   id: '1234',
    //   shopId: '123',
    //   coverImage: fullCarServiceImage,
    //   shopName: 'Abc',
    //   serviceName: 'Car Service',
    //   description: 'Hello Hi',
    //   serviceType: ServiceType.carService,
    //   vehicleType: VehicleType.bike,
    //   rating: 4.1,
    //   cost: 100,
    //   address: 'some address ',
    //   shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation,
    // ),
  ]);
  @action
  void changeSelectedVehicleType(String newVehicleType) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newVehicleService.description,
      serviceType: newVehicleService.serviceType,
      vehicleType: getVehicleTypeFromVehicleName(newVehicleType),
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeDescription(String newDescription) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newDescription,
      serviceType: newVehicleService.serviceType,
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeCost(double newCost) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newVehicleService.description,
      serviceType: newVehicleService.serviceType,
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newCost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeServiceName(String newServiceName) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newServiceName,
      description: newVehicleService.description,
      serviceType: newVehicleService.serviceType,
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeCoverImage(String newImage) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newVehicleService.description,
      serviceType: newVehicleService.serviceType,
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  void changeSelectedServiceType(String newServiceType) {
    newVehicleService = VehicleService(
      id: newVehicleService.id,
      shopId: newVehicleService.shopId,
      coverImage: newVehicleService.coverImage,
      shopName: newVehicleService.shopName,
      serviceName: newVehicleService.serviceName,
      description: newVehicleService.description,
      serviceType: getServiceTypeFromServiceName(newServiceType),
      vehicleType: newVehicleService.vehicleType,
      rating: newVehicleService.rating,
      cost: newVehicleService.cost,
      address: newVehicleService.address,
      shopLocation: newVehicleService.shopLocation,
    );
  }

  @action
  Future<FunctionResponse> addNewService() async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      fResponse = await _profileStore.loadProfile();
      fResponse.printResponse();
      if (fResponse.success) {
        ServiceShop currentUser = _profileStore.currentUser;

        newVehicleService = VehicleService(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          shopId: currentUser.id,
          coverImage: newVehicleService.coverImage,
          shopName: currentUser.name,
          serviceName: newVehicleService.serviceName,
          description: newVehicleService.description,
          serviceType: newVehicleService.serviceType,
          vehicleType: newVehicleService.vehicleType,
          rating: currentUser.rating,
          cost: newVehicleService.cost,
          address: currentUser.address,
          shopLocation: currentUser.shopLocation,
        );

        fResponse = await _customImageHelper.uploadPicture(
            (newVehicleService.coverImage), serviceShopImagesDirectory);
        if (fResponse.success) {
          changeCoverImage(fResponse.data);

          final DocumentReference fbService =
              await firestoreServicesCollection.add({
            'shopId': newVehicleService.shopId,
            'coverImage': newVehicleService.coverImage,
            'shopName': newVehicleService.shopName,
            'serviceName': newVehicleService.serviceName,
            'description': newVehicleService.description,
            'serviceType': newVehicleService.serviceType.getName(),
            'vehicleType': newVehicleService.vehicleType.getName(),
            'rating': newVehicleService.rating,
            'cost': newVehicleService.cost,
            'address': newVehicleService.address,
            'shopLocation': GeoPoint(newVehicleService.shopLocation.latitude,
                newVehicleService.shopLocation.longitude),
          });
          newVehicleService.id = fbService.id;
          vehicleServiceList.add(newVehicleService);
          fResponse.passed(message: 'Service Added Successfull');
        }
      } else {
        fResponse.failed(message: 'Current User not found');
      }
    } catch (e) {
      fResponse.failed(message: 'Error adding new service : $e');
    }
    return fResponse;
  }

  @action
  void updateServiceLocations(LatLng newLocation) {
    for (var element in vehicleServiceList) {
      element.shopLocation = newLocation;
    }
  }

  @action
  Future<void> loadAllServices() async {
    isLoadingAllServices = true;

    try {
      if (firebaseAuth.currentUser?.uid == null) {
        return;
      }

      vehicleServiceList.clear();

      await firestoreServicesCollection
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          print(' total services found : ${querySnapshot.docs.length}');
          if (doc['shopId'] == firebaseAuth.currentUser!.uid) {
            print('id : ${doc.id}');
            LatLng shopLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
            if (doc['shopLocation'] == null) {
              final GeoPoint dbLocation = doc['shopLocation'] as GeoPoint;
              shopLocation = LatLng(dbLocation.latitude, dbLocation.longitude);
            }
            print(doc.data());

            vehicleServiceList.add(VehicleService(
              id: doc.id,
              coverImage: doc['coverImage'],
              shopName: doc['shopName'],
              shopId: doc['shopId'],
              serviceName: doc['serviceName'],
              description: doc['description'],
              serviceType: getServiceTypeFromServiceName(doc['serviceType']),
              vehicleType: getVehicleTypeFromVehicleName(doc['vehicleType']),
              rating: doc['rating'],
              cost: doc['cost'],
              address: doc['address'],
              shopLocation: shopLocation,
            ));
          }
        }
      });
    } catch (e) {
      print('Error loading all services : $e');
    }

    isLoadingAllServices = false;
  }
}
