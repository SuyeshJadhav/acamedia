import 'package:flutter/material.dart';

SnackBar snackBarError(BuildContext context) {
  return SnackBar(
    content: const Text('Message inappropriate!!'),
    behavior: SnackBarBehavior.floating,
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 3),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.1,
      left: 20,
      right: 20,
    ),
  );
}
