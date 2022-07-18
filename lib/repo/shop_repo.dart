import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShopRepo {
  static final ShopRepo instance = ShopRepo();
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('shops');

  //get totalEarning field from firestore shops doc where shopId is equal to current user id
  Future<double> getTotalEarning() async {
    final DocumentSnapshot snapshot =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return ((snapshot.data()! as Map<String, dynamic>)['totalEarning'] ?? 0)
        as double;
  }
}
