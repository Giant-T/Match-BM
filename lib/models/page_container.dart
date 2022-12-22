import 'package:flutter/material.dart';
import 'package:match_bm/child_selector.dart';
import 'package:match_bm/pages/matching.dart';
import 'package:match_bm/pages/user_home.dart';

import '../pages/match_list.dart';
import 'child.dart';

class PageContainer extends StatelessWidget {
  final Widget body;

  const PageContainer({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: ValueListenableBuilder<Child?>(
            valueListenable: ChildSelector().child,
            builder: ((context, value, child) => Text(value == null
                ? "Aucun enfant sélectionné"
                : "${value.firstname} ${value.lastname}")),
          )),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => UserHome())));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite,
              ),
              onPressed: () {
                if (ChildSelector().child.value != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const Matching())));
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () {
                if (ChildSelector().child.value != null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => const MatchList())));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
