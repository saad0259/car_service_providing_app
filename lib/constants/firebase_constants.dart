import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Firestore
final firebaseFirestore = FirebaseFirestore.instance;
final firestoreUsersCollection = firebaseFirestore.collection('users');
final firestoreShopsCollection = firebaseFirestore.collection('shops');
final firestoreServicesCollection = firebaseFirestore.collection('services');
final firestoreVehiclesCollection = firebaseFirestore.collection('vehicles');
final firestoreOrdersCollection = firebaseFirestore.collection('orders');
//Firebase Storage
const String serviceShopImagesDirectory = 'service_shop_images/';
const String userImagesDirectory = 'user_images/';
//Firebase Auth
final firebaseAuth = FirebaseAuth.instance;
