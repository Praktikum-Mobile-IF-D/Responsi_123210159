import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://fake-coffee-api.vercel.app/api';

  static Future<void> register(String username, String name, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'name': name,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON.
      print('User registered successfully');
    } else {
      // If the server did not return an OK response,
      // throw an exception.
      throw Exception('Failed to register user');
    }
  }

  static Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON.
      print('User logged in successfully');
    } else {
      // If the server did not return an OK response,
      // throw an exception.
      throw Exception('Failed to login user');
    }
  }
}
