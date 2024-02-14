import 'package:flutter/material.dart';

class LogoutBtn extends StatelessWidget {
  const LogoutBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          //add logout function
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(195, 255, 0, 0),
          fixedSize: const Size(350, 55),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.logout_rounded,
              size: 25,
              color: Color.fromRGBO(247, 247, 247, 1),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Logout",
              style: TextStyle(
                color: Color.fromRGBO(247, 247, 247, 1),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}