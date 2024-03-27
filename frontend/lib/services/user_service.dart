import 'dart:convert';
import 'package:http/http.dart' as http;

class userService {
  static Future<String?> fetchUserData(String userId) async {
    final uri, url;
    uri = 'http://10.0.2.2:8000/api/user/get-user?userId=${userId}';
    url = Uri.parse(uri);

    try {
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': userId}));
      final body = jsonDecode(res.body);

      print("User Data Fetched");

      return body['fname'] + ' ' + body['lname'];
    } catch (e) {
      print('Error in fetching data: $e');
      return null;
    }
  }
}
