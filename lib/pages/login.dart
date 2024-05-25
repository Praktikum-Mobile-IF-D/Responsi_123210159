import 'package:flutter/material.dart';
import 'package:coffeeapps/service/globals.dart';
import 'package:coffeeapps/pages/home.dart';
import 'package:coffeeapps/pages/register.dart';
import 'package:coffeeapps/service/authservice.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameC = TextEditingController();
    TextEditingController passwordC = TextEditingController();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "SIGN-IN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: usernameC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Username",
              labelText: "Masukkan Username",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: passwordC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Password",
              labelText: "Masukkan Password",
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              var isLogin = await AuthService.login(
                usernameC.text,
                passwordC.text,
              );
              if (isLogin) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    content: Text('Berhasil login'),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    content: Text('Gagal login. Periksa username atau password.'),
                  ),
                );
              }
            },
            child: Text(
              'LOGIN',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: bgBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Register(),
                ),
              );
            },
            child: Text(
              'Belum Punya Akun? Daftar Sekarang',
              textAlign: TextAlign.center,
              style: TextStyle(color: bgBlue),
            ),
          )
        ],
      ),
    );
  }
}
