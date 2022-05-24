import 'package:car_service_providing_app/custom_utils/google_maps_helper.dart';
import 'package:car_service_providing_app/models/user.dart';
import 'package:car_service_providing_app/models/vehicle_service.dart';
import 'package:car_service_providing_app/resources/app_images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../constants/firebase_constants.dart';
import '../custom_utils/function_response.dart';
import '../models/service_request.dart';
import '../models/vehicle.dart';
import '../service_locator.dart';

part 'service_request_store.g.dart';

class ServiceRequestStore = _ServiceRequestStore with _$ServiceRequestStore;

abstract class _ServiceRequestStore with Store {
  @observable
  bool isLoadingOrders = false;

  @observable
  ObservableList<ServiceRequest> serviceRequestList =
      ObservableList<ServiceRequest>.of([
    // ServiceRequest(
    //   id: '123',
    //   paymentMethod: PaymentMethod.cash,
    //   dateTime: DateTime.now(),
    //   userId: '',
    //   vehicleService: VehicleService(
    //       id: '123',
    //       shopId: '123',
    //       coverImage: fullCarWashServiceImage,
    //       shopName: 'Shop name ',
    //       serviceName: 'full car service name',
    //       description: 'description',
    //       serviceType: ServiceType.carService,
    //       vehicleType: VehicleType.bike,
    //       rating: 2.2,
    //       cost: 100,
    //       address: 'address',
    //       shopLocation: GoogleMapsHelper().defaultGoogleMapsLocation),
    //   isMobile: true,
    //   serviceRequestStatus: ServiceRequestStatus.idle,
    // ),
  ]);

  @action
  Future<void> loadAllServiceRequests() async {
    isLoadingOrders = true;

    try {
      if (firebaseAuth.currentUser?.uid == null) {
        return;
      }

      serviceRequestList.clear();

      await firestoreOrdersCollection.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          print(' total orders found : ${querySnapshot.docs.length}');
          if (doc['shopId'] == firebaseAuth.currentUser!.uid) {
            print('id : ${doc.id}');

            LatLng shopLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
            LatLng userLocation = GoogleMapsHelper().defaultGoogleMapsLocation;
            if (doc['shopLocation'] == null) {
              final GeoPoint dbLocation = doc['shopLocation'] as GeoPoint;
              shopLocation = LatLng(dbLocation.latitude, dbLocation.longitude);
            }
            if (doc['userLocation'] == null) {
              final GeoPoint dbLocation = doc['userLocation'] as GeoPoint;
              userLocation = LatLng(dbLocation.latitude, dbLocation.longitude);
            }
            print(doc.data());

            serviceRequestList.add(ServiceRequest(
                id: doc.id,
                userId: doc['userId'],
                shopId: doc['shopId'],
                paymentMethod: getPaymentMethodByName(doc['paymentMethod']),
                dateTime: DateTime.parse(doc['dateTime']),
                vehicleService: VehicleService(
                  id: doc['vehicleService']['id'],
                  address: doc['vehicleService']['address'],
                  cost: doc['vehicleService']['cost'],
                  coverImage: doc['vehicleService']['coverImage'],
                  description: doc['vehicleService']['description'],
                  shopId: doc['vehicleService']['shopId'],
                  rating: doc['vehicleService']['rating'],
                  serviceName: doc['vehicleService']['serviceName'],
                  serviceType: getServiceTypeFromServiceName(
                      doc['vehicleService']['serviceType']),
                  shopLocation: shopLocation,
                  shopName: doc['vehicleService']['shopName'],
                  vehicleType: getVehicleTypeFromVehicleName(
                      doc['vehicleService']['vehicleType']),
                ),
                isMobile: doc['isMobile'],
                serviceRequestStatus:
                    getServiceRequestStatusByName(doc['serviceRequestStatus']),
                userLocation: userLocation,
                shopLocation: shopLocation));
            print(serviceRequestList.length);
          }
        }
      });
    } catch (e) {
      print('Error loading all services : $e');
    }

    isLoadingOrders = false;
  }

  Future<FunctionResponse> updateRequsetStatus(
      String serviceRequestId, ServiceRequestStatus newValue) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      await firestoreOrdersCollection
          .doc(serviceRequestId)
          .update({'serviceRequestStatus': newValue.getName()});
      ServiceRequest? updatebleRequest = serviceRequestList.firstWhere(
          (element) => element.id == serviceRequestId,
          orElse: null);
      if (updatebleRequest != null) {
        updatebleRequest = ServiceRequest(
            id: updatebleRequest.id,
            userId: updatebleRequest.userId,
            shopId: updatebleRequest.shopId,
            paymentMethod: updatebleRequest.paymentMethod,
            dateTime: updatebleRequest.dateTime,
            vehicleService: updatebleRequest.vehicleService,
            isMobile: updatebleRequest.isMobile,
            serviceRequestStatus: newValue,
            userLocation: updatebleRequest.userLocation,
            shopLocation: updatebleRequest.shopLocation);
        fResponse.passed(message: 'Request Status Updated');
      }
    } catch (e) {
      fResponse.failed(message: 'Error Canceling Request : $e');
    }
    return fResponse;
  }
}
