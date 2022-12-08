import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_bm/models/user_model.dart';

class FireStore {
  static CollectionReference get _userCollection {
    return FirebaseFirestore.instance.collection(UserModel.collection);
  }

  static void insertUser(UserModel user, String uid) async {
    await _userCollection.doc(uid).set(user.toMap());
  }

  static Future<UserModel?> getUser(String uid) async {
    return _userCollection.doc(uid).get().then((value) {
      if (!value.exists) return null;

      return UserModel(
          value.get("email"), value.get("firstname"), value.get("lastname"));
    });
  }
}
