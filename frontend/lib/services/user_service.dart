import 'dart:convert';
import 'package:http/http.dart' as http;

class userService {
  static Future<List<String>?> fetchUserData(String userId) async {
    final uri, url;
    uri = 'http://10.0.2.2:8000/api/user/get-data/Ip71HezCXgY3to3JhKAj';
    url = Uri.parse(uri);

    try {
      final res = await http.get(url);
      final body = jsonDecode(res.body);
      print(res);
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
