import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/msg_page.dart';
import 'package:frontend/util/colors.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey.shade200))),
        child: ListTile(
          tileColor: AppColors.darkWhite,
          leading: CircleAvatar(
            backgroundImage: AssetImage(chat.imageUrl),
            radius: 25.0,
          ),
          title: Text(chat.name),
          subtitle: Text(chat.recentMessage),
          trailing: chat.hasUnseenMessages
              ? const Icon(Icons.circle, color: AppColors.blackGreen, size: 11)
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
