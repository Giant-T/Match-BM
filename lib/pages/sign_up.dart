import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:match_bm/components/app_button.dart';
import 'package:match_bm/components/page_title.dart';
import 'package:match_bm/database/firestore.dart';

import '../models/user_model.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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

  // Variable pour le form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void submitUser() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      _auth
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        UserModel userModel = UserModel(_firstNameController.text,
            _lastNameController.text, _emailController.text);
        FireStore.insertUser(userModel);
      });

      _passwordError = null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _passwordError = "Le mot de passe ne respecte pas les exigences.";
      }
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
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
                        const PageTitle(text: "Entrez vos information:"),
                        TextFormField(
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return "Le champ ne peut être vide.";
                            }

                            return null;
                          }),
                          controller: _firstNameController,
                          decoration:
                              const InputDecoration(labelText: "Prénom"),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Le champ ne peut être vide.";
                            }

                            return null;
                          },
                          controller: _lastNameController,
                          decoration: const InputDecoration(labelText: "Nom"),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Le champ ne peut être vide.";
                            }

                            if (!EmailValidator.validate(value)) {
                              return "Le champ doit contenir un courriel ex: 'example@example.com'";
                            }

                            return null;
                          },
                          controller: _emailController,
                          decoration:
                              const InputDecoration(labelText: "Courriel"),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Le champ ne peut être vide.";
                            }

                            if (value.length < 7) {
                              return "Le champ doit contenir plus de 6 caractères.";
                            }

                            return null;
                          },
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: "Mot de passe",
                              errorText: _passwordError),
                        ),
                        AppButton(text: "Terminer", onPressed: submitUser),
                      ]),
                ))));
  }
}
