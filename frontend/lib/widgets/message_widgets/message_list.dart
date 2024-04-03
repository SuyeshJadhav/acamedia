import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/services/chat_service.dart';
import 'package:frontend/widgets/message_widgets/message_widget.dart';

class MessageList extends StatefulWidget {
  final List<dynamic> messages;

  const MessageList({super.key, required this.messages});

  @override
  // ignore: library_private_types_in_public_api
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _scrollController = ScrollController();
  String user1Id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  getUserId() async {
    await HelperFunctions.getUserId().then((value) => {
          if (value != null)
            {
              setState(() {
                user1Id = value;
              }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      controller: _scrollController,
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final message = widget.messages[index];
        final sender = message['sender'] != user1Id ? 'Sender2' : 'Sender1';
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: MessageWidget(
            sender: sender,
            message: message['message']
                ['text'], // Assuming 'text' holds the message content
            timestamp: ChatService.tryParseDateTime(message['timeStamp']),
            key: ValueKey(
                index), // You can provide a unique key for each message
          ),
        );
      },
    );
    // SingleChildScrollView(
    //   reverse: true,
    //   controller: _scrollController,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: widget.messages.map((message) {
    //       return SizedBox(
    //         width: MediaQuery.of(context).size.width * 0.8,
    //         child: message['message']['text'],
    //       );
    //     }).toList(),
    //   ),
    // );
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
