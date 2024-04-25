// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/util/socket_manager.dart';
import 'package:frontend/widgets/message_widgets/message_validity.dart';
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
  // final _textEditingController = TextEditingController();
  String id = '';
  String role = '';
  final _inputController = TextEditingController();

  @override
  void initState() {
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

    await HelperFunctions.getUserData().then((value) => {
          if (value != null)
            {
              setState(() {
                role = value["role"];
              })
            }
        });
  }

  Future<bool> sendMessage(msg, role) async {
    var checkValidity = await checkMessageValidity(msg, role);
    // print(checkValidity["status"]);
    // print(checkValidity["message"]);
    return checkValidity["status"];
  }

  @override
  Widget build(BuildContext context) {
    final data = context;
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
            onPressed: () async {
              // print(_textEditingController.text);
              if (await sendMessage(_inputController.text, role)) {
                onSendClick(widget.receiverId, _inputController.text);
              } else {
                ScaffoldMessenger.of(data).showSnackBar(
                  snackBarError(data),
                );
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
