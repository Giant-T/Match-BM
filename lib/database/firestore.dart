import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_bm/models/child.dart';
import 'package:match_bm/models/user_model.dart';

class FireStore {
  static CollectionReference get userCollection {
    return FirebaseFirestore.instance.collection(UserModel.collection);
  }

  static CollectionReference get childCollection {
    return FirebaseFirestore.instance.collection(Child.collection);
  }

  /// Insert un utilisateur dans la base de donnees
  static void insertUser(UserModel user, String uid) async {
    await userCollection.doc(uid).set(user.toMap());
  }

  /// Recherche l'utilisateur avec ce uid
  static Future<UserModel?> getUser(String uid) async {
    return userCollection.doc(uid).get().then((value) {
      if (!value.exists) return null;

      return UserModel(
          value.get("email"), value.get("firstname"), value.get("lastname"));
    });
  }

  /// Recherche tous les enfants avec ce parent
  static Future<List<Child>> getChildren(String parentUid) async {
    return childCollection
        .where("parent", isEqualTo: userCollection.doc(parentUid))
        .get()
        .then((value) {
      if (value.size == 0) return List<Child>.empty();

      return value.docs
          .map<Child>((c) => Child(
              c.get("firstname"),
              c.get("lastname"),
              c.get("description"),
              c.get("birthdate"),
              c.get("parent"),
              c.get("likes").isEmpty
                  ? List<DocumentReference>.empty()
                  : c.get("likes"),
              ref: c.id))
          .toList();
    });
  }

  /// Insert un enfant dans la base de donnees
  static Future<void> insertChild(Child child) async {
    await childCollection.doc().set(child.toMap());
  }

  /// Supprime un enfant de la base de donnees
  static Future<void> deleteChild(Child child) async {
    await childCollection.doc(child.ref).delete();
  }

  /// Cherche un enfant aleatoire qui n'est pas du meme parent.
  static Future<Child?> getMatch(String parentUid) async {
    return childCollection
        .where("parent", isNotEqualTo: userCollection.doc(parentUid))
        .get()
        .then((value) {
      if (value.docs.isEmpty) return null;

      Random rng = Random();

      var c = value.docs[rng.nextInt(value.docs.length - 1)];

      print(c);

      return Child(
          c.get("firstname"),
          c.get("lastname"),
          c.get("description"),
          c.get("birthdate"),
          c.get("parent"),
          c.get("likes").isEmpty
              ? List<DocumentReference>.empty()
              : c.get("likes"),
          ref: c.id);
    });
  }
}
