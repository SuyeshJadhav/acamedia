import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // debugShowCheckedModeBanner: false, home: HomePage());
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
