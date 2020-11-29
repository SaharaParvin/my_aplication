import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rlearn5/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RLearn());
}

class RLearn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      theme:
          ThemeData(primaryColor: Colors.blueGrey, accentColor: Colors.black12),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
