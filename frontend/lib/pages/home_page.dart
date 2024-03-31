import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
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
  Map<String, dynamic> user = {};
  String name = '';

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  fetchUserData() async {
    await HelperFunctions.getUserData().then((value) {
      if (value != null && value['fname'] != null && value['lname'] != null) {
        setState(() {
          user = value;
          name = '${value['fname']} ${value['lname']}';
        });
      }
    });
  }

  // fetchUserData(userId) async {
  //   await userService.fetchUsername(userId).then((value) => {
  //         if (value != null)
  //           {
  //             setState(() {
  //               User = value;
  //               name = User['fname'] + ' ' + User['lname'];
  //             })
  //           }
  //       });
  // }

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
            Expanded(child: Chats()),
          ],
        ),
      ),
    );
  }
}
