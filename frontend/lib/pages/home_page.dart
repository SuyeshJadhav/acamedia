import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/widgets/home_widgets/home_appbar.dart';
import 'package:frontend/widgets/home_widgets/home_drawer.dart';
// import '../widgets/home_widgets/chat_tile.dart';
import 'package:http/http.dart' as http;
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
  String fname = '', lname = '';

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const HomeAppBar(),
      drawer: SafeArea(child: HomeDrawer(fname, lname)),
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

  void fetchUserData(String userId) async {
    final uri, url;
    uri = 'http://localhost:8000/api/user/get-user?userId=${userId}';
    url = Uri.parse(uri);

    try {
      final res = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': userId}));
      final body = jsonDecode(res.body);

      setState(() {
        fname = body['fname'];
        lname = body['lname'];
      });

      print("User Data Fetched");
    } catch (e) {
      print('Error in fetching data: $e');
    }
  }
}
