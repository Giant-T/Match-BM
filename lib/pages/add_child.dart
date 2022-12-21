import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:match_bm/components/app_button.dart';
import 'package:match_bm/components/page_title.dart';
import 'package:match_bm/database/firestore.dart';
import 'package:match_bm/models/child.dart';
import 'package:match_bm/models/page_container.dart';
import 'package:match_bm/pages/user_home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AddChild extends StatefulWidget {
  const AddChild({super.key});

  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late DateTime birthdate;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    birthdate = DateTime.now();
    _dateController.text = DateFormat("yyyy-MM-dd").format(birthdate);
  }

  void addChild() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FireStore.insertChild(Child(
        _firstnameController.text,
        _lastnameController.text,
        _descriptionController.text,
        Timestamp.fromDate(birthdate),
        FireStore.userCollection.doc(_auth.currentUser!.uid),
        [])).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserHome()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 5, right: 5),
            child: Form(
                key: _formKey,
                child: Wrap(
                  runSpacing: 20,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const PageTitle(text: "Ajout d'enfant"),
                    TextFormField(
                        controller: _firstnameController,
                        decoration: const InputDecoration(labelText: "Prénom"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le champ de ne peut être vide.";
                          }

                          return null;
                        }),
                    TextFormField(
                        controller: _lastnameController,
                        decoration:
                            const InputDecoration(labelText: "Nom de famille"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le champ de ne peut être vide.";
                          }

                          return null;
                        }),
                    TextFormField(
                        controller: _descriptionController,
                        decoration:
                            const InputDecoration(labelText: "Description"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le champ de ne peut être vide.";
                          }

                          return null;
                        }),
                    TextField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "Date de naissance",
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1990),
                              lastDate: DateTime.now());

                          if (pickedDate != null) {
                            setState(() {
                              birthdate = pickedDate;
                              _dateController.text =
                                  DateFormat("yyyy-MM-dd").format(birthdate);
                            });
                          }
                        }),
                    AppButton(text: "Ajouter", onPressed: addChild)
                  ],
                ))));
  }
}
