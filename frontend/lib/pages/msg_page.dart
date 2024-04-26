import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/services/chat_service.dart';
import 'package:frontend/util/colors.dart';
import 'package:frontend/util/socket_manager.dart';
import 'package:provider/provider.dart';
import '../widgets/message_widgets/message_list.dart';
import '../widgets/message_widgets/text_input_field.dart';

class ChatPage extends StatefulWidget {
  final String receiverName, receiverId, chatId;
  const ChatPage(
      {super.key,
      required this.receiverName,
      required this.receiverId,
      required this.chatId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> messageList = [];
  String role = '';
  String id = '';

  @override
  void initState() {
    super.initState();
    fetchMessages();
    SocketManager.initSocket(widget.chatId, updateMessageList);
    SocketManager.receiveMessage();
  }

  fetchMessages() async {
    await ChatService.fetchMessageList(widget.chatId).then((value) => {
          if (value != null)
            {
              setState(() {
                messageList = value;
              })
            }
        });

    await HelperFunctions.getUserId().then((value) => {
          if (value != null)
            {
              setState(() {
                id = value;
              })
            }
        });

    await HelperFunctions.getUserData().then((value) => {
          if (value != null)
            {
              setState(() {
                role = value["role"];
                // fname = value["fname"];
                // lname = value["lname"];
              })
            }
        });
  }

  void updateMessageList(dynamic message) {
    if (!mounted) return;
    final dndSwitchState = Provider.of<DNDSwitchState>(context, listen: false);
    if (!dndSwitchState.dndEnabled && id != message['sender']) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 0,
            channelKey: 'channel_1',
            title: widget.receiverName,
            body: message['message']['text'],
            notificationLayout: NotificationLayout.Messaging),
      );
    }

    setState(() {
      if (mounted) {
        messageList.add(message);
        ChatService.sortMessageList(messageList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        color: AppColors.lightWhite,
        // color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: MessageList(messages: messageList),
            ),
            TextInputField(
              chatId: widget.chatId,
              receiverId: widget.receiverId,
              updateMessageList: updateMessageList,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 65.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                child: Text(
                  widget.receiverName
                      .split(' ')
                      .map((namePart) => namePart[0].toUpperCase())
                      .join(''),
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                widget.receiverName,
                style: const TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
