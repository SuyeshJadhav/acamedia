import 'package:flutter/material.dart';
import 'package:frontend/util/colors.dart';
import '../widgets/message_widgets/message_list.dart';
import '../widgets/message_widgets/message_widget.dart';
import '../widgets/message_widgets/text_input_field.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        color: AppColors.lightWhite,
        child: const Column(
          children: [
            Expanded(
              child: MessageList(
                messages: [
                  MessageWidget(
                    sender: 'Sender1',
                    message:
                        'Hello my name is name Hello my name is name Hello my name is namer',
                    timestamp: 'timestamp',
                  ),
                  MessageWidget(
                    sender: 'Sender2',
                    message: 'Hello my name is name',
                    timestamp: 'timestamp',
                  ),
                  MessageWidget(
                    sender: 'Sender1',
                    message: 'Hello my name is name',
                    timestamp: 'timestamp',
                  ),
                  MessageWidget(
                    sender: 'Sender2',
                    message: 'Hello my name is name',
                    timestamp: 'timestamp',
                  ),
                  MessageWidget(
                    sender: 'Sender1',
                    message: 'Hello my name is name',
                    timestamp: 'timestamp',
                  ),
                  MessageWidget(
                    sender: 'Sender1',
                    message: 'Hello my name is name',
                    timestamp: 'timestamp',
                  ),
                  MessageWidget(
                    sender: 'Sender1',
                    message: 'Hello my name is name',
                    timestamp: 'timestamp',
                  ),
                ],
              ),
            ),
            TextInputField(),
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
          child: const Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('lib/assets/p1.jpg'),
                radius: 25.0,
              ),
              SizedBox(width: 12.0),
              Text(
                "message",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
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
