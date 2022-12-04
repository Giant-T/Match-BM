import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/components/app_button.dart';
import 'package:match_bm/components/page_title.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(10, 60, 10, 10), child: LinearProgressIndicator()),
            const Spacer(),
            const PageTitle(text: "Quel est votre prénom?"),
            const Padding(padding: EdgeInsets.all(10), child: TextField()),
            const Spacer(),
            AppButton(text: "Suivant", onPressed: () {}),
            const Spacer()
          ]),
    ));
  }
}
