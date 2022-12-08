import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/components/loader.dart';
import 'package:match_bm/database/firestore.dart';
import 'package:match_bm/models/user_model.dart';

import '../models/page_container.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserHome extends StatelessWidget {
  UserHome({Key? key}) : super(key: key);
  late UserModel? userInfo;

  Future<UserModel?> getUserInfo() async {
    userInfo = await FireStore.getUser(_auth.currentUser!.uid);
    return userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserInfo(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Loader();
          }

          return PageContainer(
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(userInfo!.firstname),
                  ]),
            ),
          );
        }));
  }
}
