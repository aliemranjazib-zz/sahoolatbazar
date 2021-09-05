import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

var imageurl =
    'https://images.unsplash.com/photo-1550355291-bbee04a92027?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=376&q=80';

TextStyle mainstyle = TextStyle(
  fontSize: 40,
  fontFamily: 'bebas',
);

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = FirebaseFirestore.instance.collection('products');
FirebaseAuth auth = FirebaseAuth.instance;

displayMessage(String message) {
  Fluttertoast.showToast(msg: message);
}
