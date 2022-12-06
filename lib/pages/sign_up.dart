import 'package:email_validator/email_validator.dart';
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

  // Variable pour le form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _passwordError = null;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void submitUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.value.text,
              password: _passwordController.value.text);

      UserModel userModel = UserModel(_firstNameController.value.text,
          _lastNameController.value.text, _emailController.value.text);
      FireStore.insertUser(userModel);
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
