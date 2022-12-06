import 'package:cloud_firestore/cloud_firestore.dart';

class Child {
  String firstname;
  String lastname;
  String description;
  Timestamp birthdate;
  DocumentReference parent;
  List<DocumentReference> likes;

  Child(this.firstname, this.lastname, this.description, this.birthdate,
      this.parent, this.likes);
}
