import 'package:flutter/material.dart';
import 'package:frontend/pages/call_page.dart';
import 'package:frontend/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    // const Chat(
    //     name: 'Jane Smith',
    //     imageUrl: 'https://example.com/profile2.jpg',
    //     recentMessage: 'Check out this video!',
    //     hasUnseenMessages: false),
    // const Chat(
    //     name: 'Jane Smith',
    //     imageUrl: 'https://example.com/profile2.jpg',
    //     recentMessage: 'Check out this video!',
    //     hasUnseenMessages: false),
    // const Chat(
    //     name: 'Jane Smith',
    //     imageUrl: 'https://example.com/profile2.jpg',
    //     recentMessage: 'Check out this video!',
    //     hasUnseenMessages: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 65.0,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          'Chats',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.menu),
            ),
          ),
        ],
      ),
      endDrawer: Padding(
        padding: const EdgeInsets.only(top: 52.0),
        child: Drawer(
          width: 65.0,
          child: Container(
            color: const Color.fromRGBO(229, 245, 228, 1),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://example.com/profile_image.jpg'),
                        radius: 25.0,
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 21.0,
                        top: 10.0,
                      ),
                      leading: const Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 27.0,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchPage()));
                      },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 22.0,
                        top: 10.0,
                      ),
                      leading: const Icon(
                        Icons.call,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CallPage()));
                      },
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 22.0,
                        top: 10.0,
                      ),
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      onTap: () {},
                    ),
                    // Add more ListTile items as needed
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
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
        tileColor: const Color.fromARGB(255, 248, 248, 248),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chat.imageUrl),
          backgroundColor: const Color.fromRGBO(228, 245, 245, 1),
          // backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
      ),
    );
  }
}
