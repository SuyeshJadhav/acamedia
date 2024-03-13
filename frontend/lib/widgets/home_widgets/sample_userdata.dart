import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:http/http.dart' as http;

class chats extends StatefulWidget {
  const chats({super.key});

  @override
  State<chats> createState() => _chatsState();
}

class _chatsState extends State<chats> {
  List<dynamic> chatList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              final chat = chatList[index];
              final email = chat['email'];
              final recentMessage = 'Hey, how are you?';
              return ListTile(
                leading: CircleAvatar(child: Text(email[0])),
                title: Text(email),
                subtitle: Text(recentMessage),
              );
            }));
  }

  void fetchUsers() async {
    const uri = 'https://randomuser.me/api/?results=10';
    final url = Uri.parse(uri);
    final res = await http.get(url);
    final body = res.body;
    final json = jsonDecode(body);

    setState(() {
      chatList = json['results'];
    });

    print("Users fetched");
  }
}


//   const Chat(
//     name: 'John Doe',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: 'Hey, how are you?',
//     hasUnseenMessages: true,
//   ),
//   const Chat(
//     name: 'Jane Smith',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: 'Check out this video!',
//     hasUnseenMessages: false,
//   ),
//   const Chat(
//     name: 'Alex Johnson',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: 'Meeting at 2 PM',
//     hasUnseenMessages: true,
//   ),
//   const Chat(
//     name: 'Emily Brown',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: 'Can you call me?',
//     hasUnseenMessages: false,
//   ),
//   const Chat(
//     name: 'Michael Wilson',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: "🎉 Let's celebrate!",
//     hasUnseenMessages: true,
//   ),
//   const Chat(
//     name: 'Sophia Miller',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: "Don't forget the deadline!",
//     hasUnseenMessages: false,
//   ),
//   const Chat(
//     name: 'Daniel Davis',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: 'Just got back from vacation!',
//     hasUnseenMessages: true,
//   ),
//   const Chat(
//     name: 'Olivia White',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: 'Sending you the files now.',
//     hasUnseenMessages: false,
//   ),
//   const Chat(
//     name: 'Liam Moore',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: 'Happy birthday!',
//     hasUnseenMessages: true,
//   ),
//   const Chat(
//     name: 'Ava Taylor',
//     imageUrl: 'lib/assets/p1.jpg',
//     recentMessage: "Let's grab lunch tomorrow.",
//     hasUnseenMessages: false,
//   ),
// ];

