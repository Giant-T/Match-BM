import 'package:flutter/material.dart';
import 'package:match_bm/components/app_button.dart';
import 'package:match_bm/components/page_title.dart';
import 'package:match_bm/pages/sign_in.dart';
import 'package:match_bm/pages/sign_up.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
          child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        direction: Axis.vertical,
        spacing: 10,
        runSpacing: 10,
        children: [
          const PageTitle(text: "Accueil"),
          AppButton(
              text: "Se connecter",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignIn()));
              }),
          AppButton(
              text: "S'inscrire",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              })
        ],
      )),
    );
  }
}
