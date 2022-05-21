import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Firestore
final firebaseFirestore = FirebaseFirestore.instance;
final firestoreShopsCollection = firebaseFirestore.collection('shops');
final firestoreServicesCollection = firebaseFirestore.collection('services');
//Firebase Storage
const String serviceShopImagesDirectory = 'service_shop_images/';
//Firebase Auth
final firebaseAuth = FirebaseAuth.instance;
