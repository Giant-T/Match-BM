import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/components/loader.dart';
import 'package:match_bm/models/page_container.dart';

import '../database/firestore.dart';
import '../models/child.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Matching extends StatefulWidget {
  const Matching({super.key});

  @override
  State<Matching> createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  Child? match;

  Future<Child?> getMatch() async {
    return FireStore.getMatch(_auth.currentUser!.uid).then((value) {
      match = value;
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMatch(),
        initialData: null,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Loader();
          }

          return PageContainer(
              body: Column(
            children: [Text("${match!.firstname} ${match!.lastname}")],
          ));
        }));
  }
}
