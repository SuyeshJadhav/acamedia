import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/util/message_notification.dart';
import 'package:frontend/util/notification_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  await initializeNotifications();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DNDSwitchState(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isLoggedIn = false;
  String userId = '';
  @override
  void initState() {
    super.initState();
    // initializeSocket();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
    getLoggedInStatus();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: MainApp.navigatorKey,
      home: _isLoggedIn ? HomePage(userId: userId) : const LoginPage(),
    );
  }
}
