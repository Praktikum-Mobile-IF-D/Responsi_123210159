import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffeeapps/response/kopi.dart';

class ApiClient {
  static Future<JenisKopi> fetchData() async {
    var response = await http.get(Uri.parse('https://fake-coffee-api.vercel.app/api'));
    JenisKopi kopi = JenisKopi.fromJson(jsonDecode(response.body));
    return kopi;
  }

  static Future<void> addFavorite(JenisKopi kopi) async {
    final prefs = await SharedPreferences.getInstance();
    final String? favorite = prefs.getString('favorite');
    List<dynamic> favoriteList = favorite != null ? jsonDecode(favorite) : [];
    favoriteList.add(kopi.toJson());
    await prefs.setString('favorite', jsonEncode(favoriteList));
  }

  static Future<JenisKopi?> findKopiById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final String? favorite = prefs.getString('favorite');

    if (favorite != null) {
      List<dynamic> favoriteList = jsonDecode(favorite);

      for (var favorite in favoriteList) {
        final kopi = JenisKopi.fromJson(favorite);
        if (kopi.id == id) {
          return kopi;
        }
      }
    }

    return null;
  }

  static Future<void> removeFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final String? favorite = prefs.getString('favorite');

    if (favorite != null) {
      List<dynamic> favoriteList = jsonDecode(favorite);

      for (var i = 0; i < favoriteList.length; i++) {
        final kopi = JenisKopi.fromJson(favoriteList[i]);
        if (kopi.id == id) {
          favoriteList.removeAt(i);
          break;
        }
      }

      await prefs.setString('favorite', jsonEncode(favoriteList));
    }
  }

  static Future<List<JenisKopi>> fetchFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoriteJson = prefs.getString('favorite');

    List<JenisKopi> favorite = [];

    if (favoriteJson != null) {
      List<dynamic> favoriteList = jsonDecode(favoriteJson);

      for (var favorite in favoriteList) {
        final kopi = JenisKopi.fromJson(favorite);
        favorite.add(kopi);
      }
    }
    print(favorite);
    return favorite;
  }
}
