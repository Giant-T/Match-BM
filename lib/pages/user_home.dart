import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/components/app_button.dart';
import 'package:match_bm/components/children_list.dart';
import 'package:match_bm/components/loader.dart';
import 'package:match_bm/components/page_title.dart';
import 'package:match_bm/database/firestore.dart';
import 'package:match_bm/models/user_model.dart';
import 'package:match_bm/pages/add_child.dart';

import '../models/page_container.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserHome extends StatelessWidget {
  UserHome({Key? key}) : super(key: key);
  late UserModel? userInfo = UserModel("", "", "");

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
              body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 5, right: 5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  PageTitle(
                      text:
                          "Bonjour ${userInfo!.firstname} ${userInfo!.lastname}!"),
                  ChildrenList(),
                  AppButton(
                      text: "Ajouter un enfant",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddChild()));
                      })
                ]),
          ));
        }));
  }
}
