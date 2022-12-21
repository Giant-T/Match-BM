import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/database/firestore.dart';
import 'package:match_bm/models/child.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ChildrenList extends StatelessWidget {
  late List<Child> children = List.empty();

  ChildrenList({Key? key}) : super(key: key);

  Future<List<Child>> getChildren() async {
    children = await FireStore.getChildren(_auth.currentUser!.uid);
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getChildren(),
        builder: (context, snapshot) {
          return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    final child = children[index];

                    return Dismissible(
                      key: Key(index.toString()),
                      onDismissed: (direction) async {
                        FireStore.removeChild(child).then((value) {
                          children.removeAt(index);
                        });
                      },
                      child: Text(
                        "${child.firstname} ${child.lastname}",
                        style: const TextStyle(
                            fontSize: 20),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                        height: 0.1,
                      )));
        });
  }
}
