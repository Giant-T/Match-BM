import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match BM',
      theme: ThemeData(
          fontFamily: 'Verdana',
          primaryColor: const Color(0xffff5757),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xffff5757)),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xffffebeb)))),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Color(0xffff5757),
          ),
          iconTheme: const IconThemeData(color: Color(0xffffebeb))),
      home: const Accueil('Match BM'),
    );
  }
}

class Accueil extends StatelessWidget {
  final String title;

  const Accueil(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xffff5757),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(
              Icons.home,
              size: 50,
            ),
            Icon(
              Icons.account_circle,
              size: 50,
            ),
            Icon(
              Icons.settings,
              size: 50,
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(onPressed: () {}, child: const Text("S'inscrire"))
            ]),
      ),
    );
  }
}
