import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coffeeapps/service/apiclient.dart';
import 'package:coffeeapps/service/globals.dart';
import 'package:coffeeapps/pages/detail.dart';
import 'package:coffeeapps/response/kopi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late List<JenisKopi> favorites = [];

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    // Mengambil daftar favorite dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites');

    if (favoritesJson != null) {
      List<dynamic> favoritesList = jsonDecode(favoritesJson);

      // Mengambil jenis kopi berdasarkan ID dari daftar favorite
      for (var favorite in favoritesList) {
        final jenisKopi = await ApiClient.fetchData(favorite['id']);
        if (jenisKopi != null) {
          setState(() {
            favorites.add(jenisKopi);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final jenisKopi = favorites[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Detail(jenisKopi: jenisKopi);
                },
              ));
            },
            title: Text(jenisKopi.name ?? ''),
            subtitle: Text(jenisKopi.description ?? ''),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                // Menghapus jenis kopi dari daftar favorite dan memperbarui tampilan
                await ApiClient.removeFavorite(jenisKopi.id!);
                setState(() {
                  favorites.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
