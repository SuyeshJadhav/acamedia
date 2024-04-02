import 'dart:convert';
import 'package:http/http.dart' as http;

class userService {
  static Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    final uri, url;
    uri = 'http://10.0.2.2:8000/api/user/get-data/${userId}';
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
}
