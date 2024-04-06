import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:frontend/pages/login_page.dart';

class LogoutBtn extends StatefulWidget {
  const LogoutBtn({
    super.key,
  });

  @override
  State<LogoutBtn> createState() => _LogoutBtnState();
}

class _LogoutBtnState extends State<LogoutBtn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 10.0), // Adjust the content padding
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      logout();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          // backgroundColor: const Color.fromARGB(195, 255, 0, 0),
          backgroundColor: Color.fromARGB(255, 255, 200, 196),
          fixedSize: const Size(350, 55),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          // side: const BorderSide(
          //   width: 2, // Specify the border thickness
          //   color: Colors.red, // Specify the border color
          // ),
        ),
        child: const Row(
          children: [
            SizedBox(
              width: 88,
            ),
            Icon(
              Icons.logout_rounded,
              size: 25,
              color: Colors.red,
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              "Logout",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logout() async {
    await HelperFunctions.removeUser().then((value) => {
          if (value)
            {
              HelperFunctions.setLoggedInStatus(false),
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              )
            }
        });
  }
}
