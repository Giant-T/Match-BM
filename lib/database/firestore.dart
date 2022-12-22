import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                  ? List<String>.empty(growable: true)
                  : c
                      .get("likes")
                      .map<String>((element) => element.toString())
                      .toList(growable: true),
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
  static Future<Child?> getBachelors(
      String parentUid, List<String> likes) async {
    return childCollection
        .where("parent", isNotEqualTo: userCollection.doc(parentUid))
        .where("")
        .get()
        .then((value) {
      if (value.size == 0) return null;

      var values =
          value.docs.where((element) => !likes.contains(element.id)).toList();

      if (values.isEmpty) return null;

      Random rng = Random();

      var c = values[rng.nextInt(values.length)];

      return Child(
          c.get("firstname"),
          c.get("lastname"),
          c.get("description"),
          c.get("birthdate"),
          c.get("parent"),
          c.get("likes").isEmpty
              ? List<String>.empty(growable: true)
              : c
                  .get("likes")
                  .map<String>((element) => element.toString())
                  .toList(growable: true),
          ref: c.id);
    });
  }

  /// Ajoute un like a un enfant.
  static Future<Child> likeChild(Child selectedChild, Child other) async {
    selectedChild.likes.add(other.ref);
    childCollection
        .doc(selectedChild.ref)
        .update({"likes": selectedChild.likes});

    return selectedChild;
  }

  /// Retourne tous les matches de l'enfant.
  static Future<List<Child>> getMatches(Child selectedChild) async {
    return childCollection
        .where(FieldPath.documentId, whereIn: selectedChild.likes)
        .get()
        .then((value) {
      if (value.docs.isEmpty) return List.empty();

      var matches = value.docs.where((element) {
        List<String> likes = element.get("likes").isEmpty
            ? List<String>.empty(growable: true)
            : element
                .get("likes")
                .map<String>((element) => element.toString())
                .toList(growable: true);

        return likes.contains(selectedChild.ref);
      });

      return matches
          .map<Child>((c) => Child(
              c.get("firstname"),
              c.get("lastname"),
              c.get("description"),
              c.get("birthdate"),
              c.get("parent"),
              c.get("likes").isEmpty
                  ? List<String>.empty(growable: true)
                  : c
                      .get("likes")
                      .map<String>((element) => element.toString())
                      .toList(growable: true),
              ref: c.id))
          .toList();
    });
  }
}
