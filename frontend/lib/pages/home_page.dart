import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Chat> sampleChats = [
    const Chat(
        name: 'John Doe',
        imageUrl: 'https://example.com/profile1.jpg',
        recentMessage: 'Hey, how are you?',
        hasUnseenMessages: true),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    const Chat(
        name: 'Jane Smith',
        imageUrl: 'https://example.com/profile2.jpg',
        recentMessage: 'Check out this video!',
        hasUnseenMessages: false),
    // ... add more sample chats as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          'Chats',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Padding(
              padding: EdgeInsets.only(right: 40), // Adjust padding as needed
              child: Icon(Icons.menu),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 1.0, horizontal: 11.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              )),

          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: sampleChats.length,
              itemBuilder: (context, index) {
                return ChatTile(chat: sampleChats[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Chat {
  final String name;
  final String imageUrl;
  final String recentMessage;
  final bool hasUnseenMessages;

  const Chat({
    required this.name,
    required this.imageUrl,
    required this.recentMessage,
    this.hasUnseenMessages = false,
  });
}

class ChatTile extends StatelessWidget {
  final Chat chat;

  const ChatTile({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ListTile(
      tileColor: const Color.fromARGB(255, 245, 245, 245),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(chat.imageUrl),
        // backgroundColor: const Color.fromRGBO(228, 245, 245, 1),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        radius: 30.0,
      ),
      title: Text(chat.name),
      subtitle: Text(chat.recentMessage),
      trailing: chat.hasUnseenMessages
          ? const Icon(Icons.circle,
              color: Color.fromARGB(255, 38, 45, 37), size: 11)
          : null,
      onTap: () {
        // Handle navigation to chat screen
      },
    ));
  }
}
