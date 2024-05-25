import 'package:flutter/material.dart';
import 'package:coffeeapps/service//globals.dart';
import 'package:coffeeapps/pages/favorite.dart';
import 'package:coffeeapps/pages/dashboard.dart';
import 'package:coffeeapps/pages/login.dart';
import 'package:coffeeapps/pages/profile.dart';
import 'package:coffeeapps/service/authservice.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _curentIndex = 0;

  List<Widget> screens = [Dashboard(), Favorite(), Profile()];
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ),
                    (route) => false,
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: bgBlue,
        title: Text(
          'COFFEE APP',
          style: TextStyle(color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Implementasi fungsi pencarian di sini
                // Anda dapat memanggil fungsi di Dashboard untuk memfilter data
                (screens[_curentIndex] as Dashboard).performSearch(value);
              },
            ),
          ),
        ),
      ),
      body: screens[_curentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: _curentIndex,
        onTap: (value) {
          setState(() {
            _curentIndex = value;
          });
        },
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 189, 189, 189),
        backgroundColor: bgBlue,
        items: [
          BottomNavigationBarItem(
            label: 'HOME',
            icon: Icon(
              Icons.home,
              semanticLabel: 'HOME',
            ),
          ),
          BottomNavigationBarItem(
            label: 'FAVORITE',
            icon: Icon(
              Icons.bookmark,
              semanticLabel: 'FAVORITE',
            ),
          ),
          BottomNavigationBarItem(
            label: 'PROFILE',
            icon: Icon(
              Icons.person,
              semanticLabel: 'PROFILE',
            ),
          )
        ],
      ),
    );
  }
}
