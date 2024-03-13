import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var islogin = true;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: islogin
            ? LoginPage()
            : HomePage(
                userId: '',
              ));
  }
}
