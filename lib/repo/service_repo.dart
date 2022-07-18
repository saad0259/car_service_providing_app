import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../custom_utils/function_response.dart';

class ServiceRepo {
  static final ServiceRepo instance = ServiceRepo();
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('services');

  //update shopLocation field of all docs where shopId is equal to current user id
  Future<FunctionResponse> updateShopLocation(GeoPoint shopLocation) async {
    final FunctionResponse response = FunctionResponse();
    try {
      await collection
          .where('shopId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot doc) {
          log('hlooooooo ${doc.id}');
          collection.doc(doc.id).update({'shopLocation': shopLocation});
        });
      });
      response.passed();
    } catch (e) {
      response.failed();
      response.message = e.toString();
    }
    return response;
  }
}
