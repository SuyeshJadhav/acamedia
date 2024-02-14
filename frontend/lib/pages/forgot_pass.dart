import 'package:flutter/material.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          "forgot password",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
