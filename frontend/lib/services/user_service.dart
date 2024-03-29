import 'dart:convert';
import 'package:http/http.dart' as http;

class userService {
  static Future<List<String>?> fetchUserData(String userId) async {
    final uri, url;
    uri = 'http://10.0.2.2:8000/api/user/get-user?userId=${userId}';
    url = Uri.parse(uri);

    try {
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': userId}));
      final body = jsonDecode(res.body);
      List<String> dataList = [];
      body.forEach((key, value) {
        dataList.add('$key: $value');
      });

      print(dataList);

      return dataList;
    } catch (e) {
      print('Error in fetching data: $e');
      return null;
    }
  }
}
