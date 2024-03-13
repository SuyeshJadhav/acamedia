import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/util/colors.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLogin = true;
    final bool isDarkMode = true;
    AppColors(isDarkMode);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLogin
            ? HomePage(
                username: '',
              )
            : LoginPage());
  }
}
