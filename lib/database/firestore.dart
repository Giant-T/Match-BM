import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_bm/models/user_model.dart';

class FireStore {
  static CollectionReference get _userCollection {
    return FirebaseFirestore.instance.collection(UserModel.collection);
  }

  static void insertUser(UserModel user) {
    _userCollection.add(user.toMap());
  }
}
