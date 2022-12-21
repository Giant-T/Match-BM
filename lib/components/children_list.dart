import 'package:flutter/widgets.dart';
import 'package:match_bm/models/child.dart';

class ChildrenList extends StatelessWidget {
  final List<Child> children;

  const ChildrenList({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: children
          .map((c) => Container(
                child: Text(""),
              ))
          .toList(),
    );
  }
}
