import 'package:flutter/material.dart';
import 'package:frontend/pages/call_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Chat> sampleChats = [
    const Chat(
      name: 'John Doe',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: 'Hey, how are you?',
      hasUnseenMessages: true,
    ),
    const Chat(
      name: 'Jane Smith',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: 'Check out this video!',
      hasUnseenMessages: false,
    ),
    const Chat(
      name: 'Alex Johnson',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: 'Meeting at 2 PM',
      hasUnseenMessages: true,
    ),
    const Chat(
      name: 'Emily Brown',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: 'Can you call me?',
      hasUnseenMessages: false,
    ),
    const Chat(
      name: 'Michael Wilson',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: "🎉 Let's celebrate!",
      hasUnseenMessages: true,
    ),
    const Chat(
      name: 'Sophia Miller',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: "Don't forget the deadline!",
      hasUnseenMessages: false,
    ),
    const Chat(
      name: 'Daniel Davis',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: 'Just got back from vacation!',
      hasUnseenMessages: true,
    ),
    const Chat(
      name: 'Olivia White',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: 'Sending you the files now.',
      hasUnseenMessages: false,
    ),
    const Chat(
      name: 'Liam Moore',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: 'Happy birthday!',
      hasUnseenMessages: true,
    ),
    const Chat(
      name: 'Ava Taylor',
      imageUrl: 'lib/assets/p1.jpg',
      recentMessage: "Let's grab lunch tomorrow.",
      hasUnseenMessages: false,
    ),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ),
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(top: 52.0),
        child: Drawer(
          width: 210.0,
          child: Container(
            color: const Color.fromRGBO(229, 245, 228, 1),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 13.0, bottom: 11),
                      child: ListTile(
                        title: const Text("Name Name"),
                        leading: GestureDetector(
                          onTap: () {
                            // Handle profile icon tap, navigate to profile page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            );
                          },
                          child: const SizedBox(
                            width: 60.0, // Adjust the width as needed
                            child: CircleAvatar(
                              foregroundImage: AssetImage('lib/assets/p1.jpg'),
                              radius: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                            size: 24.0,
                          ),
                          SizedBox(width: 15.0),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.0),
                            child: Text("Search"),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Row(
                        children: [
                          Icon(
                            Icons.call_rounded,
                            color: Colors.black,
                            size: 24.0,
                          ),
                          SizedBox(width: 15.0),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.0),
                            child: Text("Calls"),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CallPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Row(
                        children: [
                          Icon(
                            Icons.settings_rounded,
                            color: Colors.black,
                            size: 24.0,
                          ),
                          SizedBox(width: 15.0),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.0),
                            child: Text("Settings"),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                    ),
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
  const Chat({
    required this.name,
    required this.imageUrl,
    required this.recentMessage,
    this.hasUnseenMessages = false,
  });

  final bool hasUnseenMessages;
  final String imageUrl;
  final String name;
  final String recentMessage;
}

class ChatTile extends StatelessWidget {
  const ChatTile({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListTile(
        tileColor: const Color.fromARGB(255, 248, 248, 248),
        leading: CircleAvatar(
          backgroundImage: AssetImage(chat.imageUrl),
          // backgroundColor: const Color.fromRGBO(228, 245, 245, 1),
          // backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          radius: 29.0,
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
