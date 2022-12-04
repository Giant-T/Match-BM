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
            child: Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
          runSpacing: 20,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const LinearProgressIndicator(),
            const PageTitle(text: "Quel est votre prénom?"),
            const TextField(),
            AppButton(text: "Suivant", onPressed: () {}),
          ]),
    )));
  }
}
