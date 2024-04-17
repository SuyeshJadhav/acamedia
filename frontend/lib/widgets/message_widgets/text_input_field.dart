import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/util/socket_manager.dart';
import 'package:frontend/widgets/message_widgets/snack_bar.dart';

class TextInputField extends StatefulWidget {
  final String? chatId, receiverId;
  final Function(dynamic) updateMessageList;
  const TextInputField(
      {super.key,
      this.chatId,
      this.receiverId,
      required this.updateMessageList});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final _textEditingController = TextEditingController();
  String id = '';
  final _inputController = TextEditingController();
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
                id = value;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              size: 28,
            ),
            color: Colors.black,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _inputController,
              // Your text input field configuration
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 9),
                hintText: 'Type a message...',
                fillColor: const Color.fromRGBO(248, 248, 248, 1),
                filled: true,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintStyle: TextStyle(
                    color: Colors.grey[600]), // Change the hint color here
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.black, // Change the send button color here
            onPressed: () {
              onSendClick(widget.receiverId, _inputController.text);
              if (_textEditingController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  snackBarError(context),
                );
              } else {
                // Send the message
                _textEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  void onSendClick(String? receiver, String msg) {
    if (receiver != null) {
      DateTime currentDate = DateTime.now();
      String formattedDate =
          '${currentDate.year}${(currentDate.month).toString().padLeft(2, "0")}${currentDate.day.toString().padLeft(2, "0")}${currentDate.hour.toString().padLeft(2, "0")}${currentDate.minute.toString().padLeft(2, "0")}${currentDate.second.toString().padLeft(2, "0")}';
      // String formattedTime =
      print(formattedDate);

      final message = {
        "message": {
          "text": msg,
        },
        "sender": id,
        "timeStamp": formattedDate,
        // "chatID": widget.chatId,
      };

      setState(() {
        _inputController.text = '';
      });

      SocketManager.sendMessage(message, widget.updateMessageList);
      // widget.updateMessageList(message);
    }
  }
}
