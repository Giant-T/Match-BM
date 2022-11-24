import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Map<int, Color> color = {
    50: const Color.fromRGBO(0xff, 0xeb, 0xeb, 1),
    100: const Color.fromRGBO(0xff, 0x85, 0x85, 1),
    200: const Color.fromRGBO(0xff, 0x57, 0x57, 1),
    300: const Color.fromRGBO(0xff, 0x00, 0x7b, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match BM',
      theme: ThemeData(primarySwatch: Colors.pink),
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
        child: Stack(
          alignment: Alignment.center,
          children: const [
            Icon(
              Icons.home,
              color: Color(0xffffebeb),
              size: 50,
            ),
            Icon(
              Icons.account_circle,
              color: Color(0xffffebeb),
              size: 50,
            ),
            Icon(
              Icons.settings,
              color: Color(0xffffebeb),
              size: 50,
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Text('Accueil')],
        ),
      ),
    );
  }
}
