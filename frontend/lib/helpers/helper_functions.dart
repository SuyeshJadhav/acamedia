import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
//Store Data--------------------------------------------------------------------------------------------------

  static void setLoggedInStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedInStatus', status);
  }

  static void setUserId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);
  }

  static Future<bool> setUserData(List<String> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('userData', data);
    return true;
  }

//Get Data------------------------------------------------------------------------------------------------------
  static Future<bool?> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool('loggedInStatus');
    if (status != null) {
      return status;
    } else {
      return null;
    }
  }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('userId');
    if (id != null) {
      return id;
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dataList = prefs.getStringList('userData');
    if (dataList != null) {
      List<String> keysList = dataList.map((string) {
        List<String> parts = string.split(': ');
        return parts[0];
      }).toList();
      List<dynamic> valuesList = dataList.map((string) {
        List<dynamic> parts = string.split(': ');
        return parts[1];
      }).toList();

      Map<String, dynamic> data = {};
      for (int i = 0; i < keysList.length; i++) {
        data[keysList[i]] = valuesList[i];
      }

      print("data fetched!");
      return data;
    } else {
      return null;
    }
  }

  //Remove Data

  static Future<bool> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.remove('userId');
      await prefs.remove('userData');
      print("User Removed!");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
