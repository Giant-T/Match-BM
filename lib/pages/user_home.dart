import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/components/loader.dart';
import 'package:match_bm/database/firestore.dart';
import 'package:match_bm/models/user_model.dart';

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

          return Scaffold(
            bottomNavigationBar: BottomAppBar(
              color: const Color(0xffff5757),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.home,
                    size: 50,
                  ),
                  Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
                  Icon(
                    Icons.settings,
                    size: 50,
                  )
                ],
              ),
            ),
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
