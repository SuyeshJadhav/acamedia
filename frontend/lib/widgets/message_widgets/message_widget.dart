import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageWidget extends StatelessWidget {
  final String sender;
  final String message;
  final String timestamp; // Add the timestamp parameter

  const MessageWidget({
    required this.sender,
    required this.message,
    required this.timestamp, // Ensure the timestamp is required
    super.key,
  });

  Widget _getMessageWidget({double? maxWidth}) {
    Color backgroundColor = sender == 'Sender1'
        ? const Color.fromRGBO(42, 82, 81, 1)
        : const Color.fromRGBO(229, 245, 228, 1);
    Color fontColor = sender == 'Sender1' ? Colors.white : Colors.black;
    CrossAxisAlignment alignMsg =
        sender == 'Sender1' ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    MainAxisAlignment alignTime =
        sender == 'Sender1' ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: alignMsg,
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                // Handle onTap for this specific message using index
                // print('Tapped on message at index: $index');
              },
              onLongPress: () {
                // Trigger reply action on long press
                // if (onReply != null) {
                //   onReply!();
                // }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: maxWidth ?? double.infinity,
                      ),
                      child: Text(
                        message,
                        style: GoogleFonts.roboto(
                            textStyle:
                                TextStyle(color: fontColor, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: alignTime,
            children: [
              Text(
                'timestamp', // Display the provided timestamp
                style: GoogleFonts.roboto(
                    textStyle:
                        TextStyle(color: Colors.grey[850], fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.8;
    return Row(
      mainAxisAlignment:
          sender == 'Sender1' ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (sender == 'Sender1') const SizedBox(width: 16),
        Expanded(
          flex: 8,
          child: _getMessageWidget(maxWidth: maxWidth),
        ),
        if (sender == 'Sender2') const SizedBox(width: 16),
      ],
    );
  }
}
