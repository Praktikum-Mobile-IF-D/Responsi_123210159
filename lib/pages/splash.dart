import 'package:flutter/material.dart';
import 'package:coffeeapps/service/apiclient.dart';
import 'package:coffeeapps/service/globals.dart';
import 'package:coffeeapps/pages/home.dart';
import 'package:coffeeapps/pages/login.dart';
import 'package:coffeeapps/service/authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserLogin();
  }

  Future<void> checkUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLogin = await sharedPreferences.getBool(AuthService.loggedInKey);
    if (isLogin != null) {
      if (!isLogin) {
        Future.delayed(
          Duration(seconds: 2),
              () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) {
                return Login();
              },
            ), (route) => false);
          },
        );
      } else {
        Future.delayed(
          Duration(seconds: 2),
              () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) {
                return Home();
              },
            ), (route) => false);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'JOBS REMOTE APPS',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
