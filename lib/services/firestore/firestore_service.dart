import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeUserData({
    required String uid,
    required String email,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'uid': uid,
        'isProfileCompleted':false
      });
    } catch (e) {
      print(e);
    }
  }
}