// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;

class userService {
  static Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    final uri, url;
    uri = 'http://10.0.2.2:8000/api/user/get-data/$userId';
    url = Uri.parse(uri);

    try {
      final res = await http.get(url);
      final body = jsonDecode(res.body);

      return body;
    } catch (e) {
      print('Error in fetching data: $e');
      return null;
    }
  }

  static Future<List<dynamic>?> searchUserList(
      String query, String role, String branch) async {
    final uri, url;
    uri =
        'http://10.0.2.2:8000/api/user/search?text=$query&role=$role&branch=$branch';
    url = Uri.parse(uri);

    try {
      final res = await http.get(url);
      final body = jsonDecode(res.body);

      return body['result'];
    } catch (e) {
      print("Error in searching users: $e");
      return null;
    }
  }
}
