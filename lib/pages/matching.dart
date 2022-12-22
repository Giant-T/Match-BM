import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/components/page_title.dart';
import 'package:match_bm/models/page_container.dart';

import '../child_selector.dart';
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

  Future<void> getBachelors() async {
    try {
      return FireStore.getBachelors(
              _auth.currentUser!.uid, ChildSelector().child.value!.likes)
          .then((value) {
        setState(() {
          match = value;
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> like() async {
    try {
      if (match != null) {
        FireStore.likeChild(ChildSelector().child.value!, match!).then((value) {
          ChildSelector().child.value = value;
          getBachelors();
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getBachelors();
  }

  @override
  Widget build(BuildContext context) {
    if (match == null) {
      return const PageContainer(
          body: Center(
        child: PageTitle(text: "Aucun célibataire en vue!"),
      ));
    }

    return PageContainer(
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              runSpacing: 20,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.blueGrey[400],
                    child: PageTitle(text: match!.description),
                  ),
                ),
                Text(match == null
                    ? "Aucun enfant trouvé."
                    : "${match!.firstname} ${match!.lastname}"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: getBachelors,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: like,
                        icon: const Icon(
                          Icons.favorite,
                          color: Color(0xffff5757),
                          size: 30,
                        ))
                  ],
                )
              ],
            )));
  }
}
