import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/pages/msg_page.dart';
import 'package:frontend/services/chat_service.dart';
// import 'package:frontend/services/chat_service.dart';
import 'package:frontend/services/user_service.dart';
import '../widgets/search_widgets/filter_button.dart';
import '../widgets/search_widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isLoading = false;
  String oldQuery = "", query = "", role = "none", branch = "none", userId = "";
  List<dynamic> results = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  void getUserId() async {
    await HelperFunctions.getUserId().then((value) => {
          if (value != null)
            {
              setState(() {
                userId = value;
              })
            }
        });
  }

  void onChangedQuery(String newQuery) {
    setState(() {
      oldQuery = query;
      query = newQuery;
      _isLoading = true;
    });
    getSearchResults(query, role, branch);
  }

  void setRoleSelected(String newRole) {
    setState(() {
      role = newRole;
    });
  }

  void setBranchSelected(String newBranch) {
    setState(() {
      branch = newBranch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          "Search Page",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromARGB(255, 248, 248, 248),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchBox(onChangedQuery: onChangedQuery),
                ),
                FilterButton(
                  setBranchSelected: setBranchSelected,
                  setRoleSelected: setRoleSelected,
                ),
              ],
            ),
            Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 0.5,
                                        color: Colors.grey.shade200))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ListTile(
                                  onTap: () {
                                    onPressedChat(
                                        userId,
                                        results[index]['userId'],
                                        "${results[index]['fname']} ${results[index]['lname']}");
                                  },
                                  leading: CircleAvatar(
                                    radius: 30.0,
                                    child: Text(
                                        "${results[index]['fname'][0].toString().toUpperCase()}${results[index]['lname'][0].toString().toUpperCase()}"),
                                  ),
                                  title: Text(
                                      "${results[index]['fname']} ${results[index]['lname']}")),
                            ),
                          );
                        },
                      ))
          ],
        ),
      ),
    );
  }

  void getSearchResults(String query, String role, String branch) async {
    query = query.toLowerCase();
    final results = await userService.searchUserList(query, role, branch);
    if (results != null) {
      setState(() {
        this.results = results;
        _isLoading = false;
      });
    }
  }

  void onPressedChat(
      String user1Id, String user2Id, String receiverName) async {
    String chatId = '';
    await ChatService.openChat(user1Id, user2Id).then((value) => {
          if (value != null)
            {chatId = value, _pageRoute(chatId, user2Id, receiverName)}
        });
  }

  void _pageRoute(String chatId, String user2Id, String receiverName) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPage(
                  chatId: chatId,
                  receiverId: user2Id,
                  receiverName: receiverName,
                )));
  }
}

// bool isExistingChat(String userId) async {}

class ChatItem {
  String name;
  List<String> tags;

  ChatItem({required this.name, required this.tags});
}
