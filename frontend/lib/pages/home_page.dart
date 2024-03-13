import 'package:flutter/material.dart';
import 'package:frontend/widgets/home_widgets/home_appbar.dart';
import 'package:frontend/widgets/home_widgets/home_drawer.dart';
import '../widgets/home_widgets/chat_tile.dart';
import '../widgets/home_widgets/sample_userdata.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  // get username => null;

  @override
  // ignore: library_private_types_in_public_api
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const HomeAppBar(),
      drawer: const SafeArea(child: HomeDrawer()),
      body: Container(
        color: const Color.fromRGBO(248, 248, 248, 1),
        child: Column(
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
      ),
    );
  }
}
