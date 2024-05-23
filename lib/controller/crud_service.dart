import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CRUDservice {
  static Future saveUserToken(String token) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {"email": user!.email, "token": token};

    try {
      await FirebaseFirestore.instance
          .collection("user_data")
          .doc(user.uid)
          .set(data);

      debugPrint("Document Added");
    } catch (e) {
      debugPrint("Error is store data in firestore");
      debugPrint(e.toString());
    }
  }
}
