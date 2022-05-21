import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Firestore
final firebaseFirestore = FirebaseFirestore.instance;
final firestoreShops = FirebaseFirestore.instance.collection('shops');
//Firebase Storage
const String serviceShopImages = 'service_shop_images/';
//Firebase Auth
final firebaseAuth = FirebaseAuth.instance;
