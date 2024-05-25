import 'package:flutter/material.dart';
import 'package:coffeeapps/pages/login.dart';
import 'package:coffeeapps/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // optional: remove debug banner
      home: SplashScreen(),
    );
  }
}
