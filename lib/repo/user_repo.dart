import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  static final UserRepo instance = UserRepo();
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Future<GeoPoint> getUserLatLng(String userId) async {
    final doc = await collection.doc(userId).get();
    return ((doc.data()! as Map<String, dynamic>)['userLatLng']) as GeoPoint;
  }
}
