import 'package:cloud_firestore/cloud_firestore.dart';

class Child {
  static const String collection = "child";

  String ref;
  String firstname;
  String lastname;
  String description;
  Timestamp birthdate;
  DocumentReference parent;
  List<DocumentReference> likes;

  Child(this.firstname, this.lastname, this.description, this.birthdate,
      this.parent, this.likes,
      {this.ref = ''});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "firstname": firstname,
      "lastname": lastname,
      "birthdate": birthdate,
      "description": description,
      "parent": parent,
      "likes": likes
    };
  }
}
