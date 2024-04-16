import "dart:convert";
import "package:frontend/helpers/helper_functions.dart";
import "package:frontend/services/user_service.dart";
import "package:http/http.dart" as http;

class ChatService {
  static String userId = '';

  static Future<Map<String, dynamic>?> _fetchChatData(String chatId) async {
    await HelperFunctions.getUserId().then((value) => {
          if (value != null) {userId = value}
        });
    final uri, url;
    uri =
        "http://10.0.2.2:8000/api/chat/get-data?chatId=$chatId&userId=$userId";
    url = Uri.parse(uri);

    try {
      final res = await http.get(url);
      final body = jsonDecode(res.body);
      print("Chat fetch successful");
      return body;
    } catch (e) {
      print("Error getting chat data: $e");
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> fetchOtherUsers() async {
    String user2Id = '', chatId = '';
    List<dynamic> chats = [], chatIdList = [], messageList = [];
    Map<String, dynamic> chatInfo = {}, recentMessage = {};
    List<Map<String, dynamic>> chatList = [];
    await HelperFunctions.getUserData().then((value) async => {
          if (value != null)
            {
              chats = value['chats'],
              for (int i = 0; i < chats.length; i++)
                {
                  await _fetchChatData(chats[i]).then((chatData) async => {
                        if (chatData != null)
                          {
                            chatId = chats[i],
                            user2Id = chatData['otherUser'],
                            messageList = chatData['messageList'],
                            messageList.sort((a, b) {
                              String timeStampA = b['timeStamp'];
                              String timeStampB = a['timeStamp'];
                              DateTime? dateTimeA =
                                  tryParseDateTime(timeStampA);
                              DateTime? dateTimeB =
                                  tryParseDateTime(timeStampB);

                              if (dateTimeA != null && dateTimeB != null) {
                                return dateTimeA.compareTo(dateTimeB);
                              } else {
                                return 0;
                              }
                            }),
                            chatInfo = {},
                            chatIdList.add(user2Id),
                            chatInfo['receiverId'] = user2Id,
                            chatInfo['chatId'] = chatId,
                            recentMessage = messageList[0],
                            chatInfo['recentMessage'] =
                                recentMessage['message']['text'],
                            await userService
                                .fetchUserData(user2Id)
                                .then((userData) => {
                                      if (userData != null)
                                        {
                                          chatInfo['name'] = userData['fname'] +
                                              ' ' +
                                              userData['lname'],
                                        }
                                    }),
                            chatList.add(chatInfo)
                          }
                      })
                },
              // print("list: $chatList"),
            }
        });
    return chatList;
  }

  static Future<List<dynamic>?> fetchMessageList(chatId) async {
    List<dynamic> messageList = [];
    final chatData = await _fetchChatData(chatId);
    if (chatData != null) {
      if (chatData['messageList'] != null) {
        messageList = chatData['messageList'];
        messageList.sort((a, b) {
          String timeStampA = b['timeStamp'];
          String timeStampB = a['timeStamp'];
          DateTime? dateTimeA = tryParseDateTime(timeStampA);
          DateTime? dateTimeB = tryParseDateTime(timeStampB);

          if (dateTimeA != null && dateTimeB != null) {
            return dateTimeA.compareTo(dateTimeB);
          } else {
            return 0;
          }
        });
      }
      print(messageList);
      return messageList;
    } else {
      return null;
    }
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static DateTime? tryParseDateTime(String timestamp) {
    print(timestamp);
    try {
      if (timestamp.length != 14) {
        throw const FormatException('Invalid timestamp format');
      }
      int year = int.parse(timestamp.substring(0, 4));
      int month = int.parse(timestamp.substring(4, 6));
      int day = int.parse(timestamp.substring(6, 8));
      int hour = int.parse(timestamp.substring(8, 10));
      int minute = int.parse(timestamp.substring(10, 12));
      int second = int.parse(timestamp.substring(12, 14));
      return DateTime(year, month, day, hour, minute, second);
    } catch (e) {
      print('Error parsing timestamp: $e');
      return null;
    }
  }

  static List<dynamic> sortMessageList(List<dynamic> messageList) {
    messageList.sort((a, b) {
      String timeStampA = b['timeStamp'];
      String timeStampB = a['timeStamp'];
      DateTime? dateTimeA = tryParseDateTime(timeStampA);
      DateTime? dateTimeB = tryParseDateTime(timeStampB);

      if (dateTimeA != null && dateTimeB != null) {
        return dateTimeA.compareTo(dateTimeB);
      } else {
        return 0;
      }
    });
    return messageList;
  }
}
