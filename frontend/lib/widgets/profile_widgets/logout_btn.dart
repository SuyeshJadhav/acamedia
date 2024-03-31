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

  void logout() async {
    await HelperFunctions.removeUser().then((value) => {
          if (value)
            {
              HelperFunctions.setLoggedInStatus(false),
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()))
            }
        });
  }
}
