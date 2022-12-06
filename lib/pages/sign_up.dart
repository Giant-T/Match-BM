import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/components/app_button.dart';
import 'package:match_bm/components/page_title.dart';
import 'package:match_bm/database/firestore.dart';

import '../models/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void insertUser() async {
    // UserCredential user = await FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(
    //         email: _emailController.value.text,
    //         password: _passwordController.value.text);

    UserModel userModel = UserModel(_firstNameController.value.text,
        _lastNameController.value.text, _emailController.value.text);
    FireStore.insertUser(userModel);
  }

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
            const PageTitle(text: "Entrez vos information:"),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Courriel"),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Mot de passe"),
            ),
            AppButton(text: "Terminer", onPressed: insertUser),
          ]),
    )));
  }
}
