import 'package:flutter/cupertino.dart';

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
