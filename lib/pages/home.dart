import 'package:flutter/material.dart';
import 'package:match_bm/components/app_button.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Accueil",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          AppButton(text: "Se connecter", onPressed: () {}),
          AppButton(text: "S'inscrire", onPressed: () {})
        ],
      )),
    );
  }
}
