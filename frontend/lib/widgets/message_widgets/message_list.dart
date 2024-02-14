import 'package:flutter/material.dart';
import 'package:frontend/widgets/message_widgets/message_widget.dart';

class MessageList extends StatefulWidget {
  final List<MessageWidget> messages;

  const MessageList({super.key, required this.messages});

  @override
  // ignore: library_private_types_in_public_api
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.messages.map((message) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: message,
          );
        }).toList(),
      ),
    );
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
