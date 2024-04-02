import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/chat.dart';
import 'package:frontend/widgets/home_widgets/chat_tile.dart';
import 'package:http/http.dart' as http;

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
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
              final chats = chatList[index];
              final String email = chats['email'];
              const recentMessage = 'Hey, how are you?';
              Chat chat = Chat(name: email, recentMessage: recentMessage);
              // return ListTile(
              //   leading: CircleAvatar(
              //       child: Padding(
              //     padding: const EdgeInsets.only(bottom: 5),
              //     child: Text(email[0]),
              //   )),
              //   title: Text(email),
              //   subtitle: Text(recentMessage),
              // );
              return ChatTile(chat: chat);
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

