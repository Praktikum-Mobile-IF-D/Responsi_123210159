import 'package:flutter/material.dart';
import 'package:coffeeapps/service/authservice.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, String>? user = {"name": "", "username": ""};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLogin();
  }

  void getUserLogin() async {
    var userDumy = await AuthService.getCurrentUser();
    setState(() {
      user = userDumy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text('Username'),
            subtitle: Text(user![
            'username']!), // Menggunakan informasi pengguna yang diperoleh
          ),
          ListTile(
            title: Text('Name'),
            subtitle: Text(user![
            'name']!), // Menggunakan informasi pengguna yang diperoleh
          ),
          // Tambahkan info pengguna lainnya sesuai kebutuhan
        ],
      ),
    );
  }
}
