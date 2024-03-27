import 'package:flutter/material.dart';
import 'package:frontend/services/user_service.dart';
import 'package:frontend/widgets/home_widgets/home_appbar.dart';
import 'package:frontend/widgets/home_widgets/home_drawer.dart';
// import '../widgets/home_widgets/chat_tile.dart';
import '../widgets/home_widgets/sample_userdata.dart';

class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({super.key, required this.userId});

  // get userId => null;

  @override
  // ignore: library_private_types_in_public_api
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData(widget.userId);
  }

  fetchUserData(userId) async {
    await userService.fetchUserData(userId).then((value) => {
          if (value != null)
            {
              setState(() {
                name = value;
              })
            }
          else
            {name = "NAME NAME"}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const HomeAppBar(),
      drawer: SafeArea(child: HomeDrawer(name)),
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
