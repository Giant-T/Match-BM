import 'package:flutter/material.dart';
import 'package:match_bm/components/app_button.dart';
import 'package:match_bm/components/page_title.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            const PageTitle(text: "Connexion"),
            const TextField(
              decoration: InputDecoration(labelText: "Courriel"),
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Mot de passe"),
            ),
            AppButton(text: "Se connecter", onPressed: () {}),
          ],
        ),
      )),
    );
  }
}
