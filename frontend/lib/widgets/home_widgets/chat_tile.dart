import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/pages/msg_page.dart';
import 'package:frontend/util/colors.dart';
import '../chat.dart';

class ChatTile extends StatefulWidget {
  const ChatTile({super.key, required this.chat});

  final Chat chat;

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  String recentMessage = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getRecentMessage(widget.chat.chatId);
  }

  void getRecentMessage(String chatId) {
    HelperFunctions.getRecentMessage(chatId).then((value) => {
          if (value != null)
            {
              setState(() {
                recentMessage = value;
              })
            }
        });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey.shade200))),
        child: ListTile(
          tileColor: AppColors.darkWhite,
          leading: CircleAvatar(
            radius: 35.0,
            child: Text(
              widget.chat.name
                  .split(' ')
                  .map((namePart) => namePart[0].toUpperCase())
                  .join(''),
            ),
          ),
          title: Text(widget.chat.name),
          subtitle: Text(recentMessage),
          trailing: widget.chat.hasUnseenMessages
              ? const Icon(Icons.circle, color: AppColors.blackGreen, size: 11)
              : null,
          onTap: () {
            // Handle navigation to chat screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          receiverName: widget.chat.name,
                          receiverId: widget.chat.receiverId,
                          chatId: widget.chat.chatId,
                          // updateRecentMessage: updateRecentMessage,
                        )));
          },
        ),
      ),
    );
  }
}
