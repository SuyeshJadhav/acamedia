import 'package:flutter/material.dart';
import 'package:frontend/widgets/home_widgets/home_appbar.dart';
import 'package:frontend/widgets/home_widgets/home_drawer.dart';
import '../widgets/home_widgets/chat_tile.dart';
import '../widgets/home_widgets/sample_userdata.dart';

class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({Key? key, required this.userId}) : super(key: key);

  // get userId => null;

  @override
  // ignore: library_private_types_in_public_api
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const HomeAppBar(),
      drawer: const SafeArea(child: HomeDrawer()),
      body: Container(
        color: const Color.fromRGBO(248, 248, 248, 1),
        child: const Column(
          children: [
            // Chat List
            Expanded(child: chats()),
          ],
        ),
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
