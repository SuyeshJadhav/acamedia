import 'dart:convert';

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

  static Future<bool> setUserData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(data);
    await prefs.setString('userData', jsonData);
    return true;
  }

  static void setChatData(List<Map<String, dynamic>> chatList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonChatData = jsonEncode(chatList);
    await prefs.setString('chatList', jsonChatData);
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
    String? jsonData = prefs.getString('userData');
    if (jsonData != null) {
      final data = jsonDecode(jsonData);
      print("Data fetched!");

      return data;
    } else {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> getChatData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('chatList');
    if (jsonData != null) {
      List<dynamic> jsonList = jsonDecode(jsonData);

      // Convert dynamic list to List<Map<String, dynamic>>
      List<Map<String, dynamic>> dataList =
          jsonList.map((item) => item as Map<String, dynamic>).toList();

      return dataList;
    } else {
      // If JSON string is null, return null
      return null;
    }
  }

  //Remove Data--------------------------------------------------------------------------------------------------

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
