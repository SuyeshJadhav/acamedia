import 'package:flutter/material.dart';
import 'package:frontend/util/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageWidget extends StatelessWidget {
  final String sender;
  final dynamic message;
  final DateTime? timestamp;
  // final String messageId;

  const MessageWidget({
    required this.sender,
    required this.message,
    required this.timestamp,
    // required this.messageId,
    super.key,
  });

  Widget _getMessageWidget({double? maxWidth}) {
    Color backgroundColor =
        sender == 'Sender1' ? AppColors.darkGreen : AppColors.lightWhite;
    Color fontColor = sender == 'Sender1' ? Colors.white : Colors.black;
    CrossAxisAlignment alignMsg =
        sender == 'Sender1' ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    MainAxisAlignment alignTime =
        sender == 'Sender1' ? MainAxisAlignment.end : MainAxisAlignment.start;

    String minutes = timestamp!.minute < 10
        ? '0${timestamp?.minute}' // Add leading zero if minute is less than 10
        : '${timestamp?.minute}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: alignMsg,
        children: [
          Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.darkGreen, width: 1.0)),
            child: InkWell(
              onTap: () {},
              onLongPress: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 13.0, vertical: 13.0),
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
                '${timestamp?.hour}:$minutes', // Display the provided timestamp
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
      children: [
        Expanded(
          flex: 8,
          child: _getMessageWidget(maxWidth: maxWidth),
        ),
      ],
    );
  }
}
