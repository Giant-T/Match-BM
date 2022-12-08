import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:match_bm/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xffff5757);
    const Color lightColor = Color(0xffffebeb);

    return MaterialApp(
      title: 'Match BM',
      theme: ThemeData(
          fontFamily: 'Verdana',
          primaryColor: primaryColor,
          progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: primaryColor, linearTrackColor: lightColor),
          inputDecorationTheme:
              const InputDecorationTheme(border: OutlineInputBorder()),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(lightColor))),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: primaryColor,
          ),
          iconTheme: const IconThemeData(color: lightColor)),
      home: const Home(),
    );
  }
}
