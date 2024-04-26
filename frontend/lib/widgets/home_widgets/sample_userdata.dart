import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/services/chat_service.dart';
import 'package:frontend/widgets/chat.dart';
import 'package:frontend/widgets/home_widgets/chat_tile.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<Map<String, dynamic>> chatList = [];
  String recentMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatList.isEmpty
          ? const Center(
              child: CircularProgressIndicator()) // Placeholder for loading
          : ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> chatData = chatList[index];
                final String name = chatData['name'];
                final String receiverId = chatData['receiverId'];
                final String chatId = chatData['chatId'];
                // final String recentMessage = chatData['recentMessage'];
                // print("recent: $recentMessage");
                Chat chat = Chat(
                    name: name,
                    // recentMessage: recentMessage,
                    receiverId: receiverId,
                    chatId: chatId);
                return ChatTile(chat: chat);
              },
            ),
      // return ListTile(
      //   leading: CircleAvatar(
      //       child: Padding(
      //     padding: const EdgeInsets.only(bottom: 5),
      //     child: Text(name[0]),
      //   )),
      //   title: Text(email),
      //   subtitle: Text(recentMessage),
      // );
      //   return ChatTile(chat: chat);
      // })
    );
  }

  void fetchChats() async {
    await HelperFunctions.getChatData().then((value) => {
          if (value != null)
            {
              setState(() {
                chatList = value;
              })
            }
        });
    print("Chat1: $chatList");
    await ChatService.fetchOtherUsers().then((value) => {
          if (value != null)
            {
              setState(() {
                chatList = value;
                print("Chat2: $chatList");
              })
            }
        });
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

