import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/msg_page.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey.shade300))),
        child: ListTile(
          tileColor: const Color.fromRGBO(248, 248, 248, 1),
          leading: CircleAvatar(
            backgroundImage: AssetImage(chat.imageUrl),
            radius: 25.0,
          ),
          title: Text(chat.name),
          subtitle: Text(chat.recentMessage),
          trailing: chat.hasUnseenMessages
              ? const Icon(Icons.circle,
                  color: Color.fromARGB(255, 38, 45, 37), size: 11)
              : null,
          onTap: () {
            // Handle navigation to chat screen
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatPage()));
          },
        ),
      ),
    );
  }
}
