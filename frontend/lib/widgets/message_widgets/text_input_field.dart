import 'package:flutter/material.dart';
import 'package:frontend/widgets/message_widgets/snack_bar.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({super.key});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final _textEditingController = TextEditingController();

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
              controller: _textEditingController,
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
              // Handle sending the message
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
}
