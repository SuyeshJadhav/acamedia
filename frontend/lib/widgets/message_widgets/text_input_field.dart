import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({super.key});

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
              // Handle sending the message
            },
          ),
        ],
      ),
    );
  }
}
