import 'package:flutter/material.dart';
import 'package:coffeeapps/service/globals.dart';
import 'package:coffeeapps/pages/login.dart';
import 'package:coffeeapps/service/authservice.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameC = TextEditingController();
    TextEditingController userameC = TextEditingController();
    TextEditingController passwordC = TextEditingController();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            textAlign: TextAlign.center,
            "SIGN-UP",
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
            controller: nameC,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Name",
                labelText: "Masukan Nama"),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: userameC,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Username",
                labelText: "Masukan Username"),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: passwordC,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Password",
                labelText: "Masukan password"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await AuthService.register(
                  userameC.text, nameC.text, passwordC.text);
              showSuccess(context, "berhasil register silahkan login");
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ),
                    (route) => false,
              );
            },
            child: Text(
              'REGISTER',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: bgBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ),
                    (route) => false,
              );
            },
            child: Text(
              'Sudah punya akun? login sekarang',
              style: TextStyle(color: bgBlue),
            ),
          )
        ],
      ),
    );
  }
}
