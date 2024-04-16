import 'package:flutter/material.dart';
import 'package:frontend/services/chat_service.dart';
import 'package:frontend/util/colors.dart';
import 'package:frontend/util/socket_manager.dart';
import 'package:socket_io_client/socket_io_client.dart';
// import 'package:socket_io_client/socket_io_client.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMessages();
    connectSocket();
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
  }

  connectSocket() {
    Socket? socket = SocketManager.initSocket(widget.chatId);
    if (socket != null) {
      socket.on("onMessage", (msg) => {updateMessageList(msg)});

      return () => {socket.off("onMessage")};
    }
  }

  updateMessageList(dynamic Message) {
    setState(() {
      messageList.add(Message);
      ChatService.sortMessageList(messageList);
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
              child: MessageList(messages: messageList
                  // [
                  //   MessageWidget(
                  //     sender: 'Sender1',
                  //     message:
                  //         'Hello my name is name Hello my name is name Hello my name is namer',
                  //     timestamp: 'timestamp',
                  //   ),
                  //   MessageWidget(
                  //     sender: 'Sender2',
                  //     message: 'Hello my name is name',
                  //     timestamp: 'timestamp',
                  //   ),
                  //   MessageWidget(
                  //     sender: 'Sender1',
                  //     message: 'Hello my name is name',
                  //     timestamp: 'timestamp',
                  //   ),
                  //   MessageWidget(
                  //     sender: 'Sender2',
                  //     message: 'Hello my name is name',
                  //     timestamp: 'timestamp',
                  //   ),
                  //   MessageWidget(
                  //     sender: 'Sender1',
                  //     message: 'Hello my name is name',
                  //     timestamp: 'timestamp',
                  //   ),
                  //   MessageWidget(
                  //     sender: 'Sender1',
                  //     message: 'Hello my name is name',
                  //     timestamp: 'timestamp',
                  //   ),
                  //   MessageWidget(
                  //     sender: 'Sender1',
                  //     message: 'Hello my name is name',
                  //     timestamp: 'timestamp',
                  //   ),
                  // ],
                  ),
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
