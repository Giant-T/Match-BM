import 'package:flutter/material.dart';
import 'package:match_bm/child_selector.dart';
import 'package:match_bm/components/page_title.dart';
import 'package:match_bm/database/firestore.dart';
import 'package:match_bm/models/page_container.dart';

import '../models/child.dart';

class MatchList extends StatefulWidget {
  const MatchList({super.key});

  @override
  State<MatchList> createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  List<Child> matches = List<Child>.empty();

  Future<void> getMatches() async {
    FireStore.getMatches(ChildSelector().child.value!).then((value) => setState(
          () {
            matches = value;
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    getMatches();
  }

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) {
      return const PageContainer(
          body: Center(
        child: PageTitle(
          text: "Vous n'avez aucun match.",
        ),
      ));
    }

    return PageContainer(
        body: Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          var match = matches[index];
          return ListTile(
            title: PageTitle(text: "${match.firstname} ${match.lastname}"),
            subtitle: Text(match.description),
          );
        },
        itemCount: matches.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 0.3,
          );
        },
      ),
    ));
  }
}
