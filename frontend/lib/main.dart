import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/util/colors.dart';
import 'package:socket_io_client/socket_io_client.dart';
// import 'package:socket_io_client/socket_io_client.dart';

void main() async {
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isLoggedIn = false;
  String userId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSocket();
    getLoggedInStatus();
  }

  void initializeSocket() {
    Socket socket = io(
      'http://10.0.2.2:8000',
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'foo': 'bar'})
          .build(),
    );
    socket.connect();
    socket.onConnect((_) {
      print('Connected');
    });
  }

  void getLoggedInStatus() async {
    await HelperFunctions.getLoggedInStatus().then((value) => {
          if (value != null)
            {
              setState(() {
                _isLoggedIn = value;
              })
            }
        });
    if (_isLoggedIn) {
      await HelperFunctions.getUserId().then((value) => {
            if (value != null)
              {
                setState(() {
                  userId = value;
                })
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final bool isLogin = true;
    final bool isDarkMode = true;
    AppColors(isDarkMode);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _isLoggedIn ? HomePage(userId: userId) : const LoginPage());
  }
}
