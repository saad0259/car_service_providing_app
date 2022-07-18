import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/review_model.dart';

class ReviewRepo {
  static final ReviewRepo instane = ReviewRepo();

  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('reviews');

  //get all reviews where shopId is equal to current user id
  Future<List<ReviewModel>> getReviews() async {
    final QuerySnapshot snapshot = await collection
        .where('shopId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    return snapshot.docs
        .map((doc) =>
            ReviewModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }
}
