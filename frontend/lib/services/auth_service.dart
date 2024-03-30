import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<String?> authenticate(TextEditingController usernameController,
      TextEditingController passwordController) async {
    final String uri, username, password, userId;
    username = usernameController.text;
    password = passwordController.text;

    uri = 'http://10.0.2.2:8000/api/user/login';
    final url = Uri.parse(uri);
    try {
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': username, 'password': password}));

      final body = jsonDecode(res.body);
      userId = body['userId'];
      return userId;
    } catch (e) {
      print('Error during auth: $e');
      return null;
    }
  }
}
