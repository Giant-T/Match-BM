import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/child_selector.dart';
import 'package:match_bm/components/app_button.dart';
import 'package:match_bm/components/page_title.dart';
import 'package:match_bm/pages/user_home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void logIn() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      _auth
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        ChildSelector().child.value = null;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserHome()));
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 20,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const PageTitle(text: "Connexion"),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Le champ ne peut être vide.";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Courriel"),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Le champ ne peut être vide.";
                    }

                    if (value.length < 7) {
                      return "Le champ doit contenir plus de 6 caractères.";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(labelText: "Mot de passe"),
                ),
                AppButton(text: "Se connecter", onPressed: logIn),
              ],
            ),
          )),
    ));
  }
}
