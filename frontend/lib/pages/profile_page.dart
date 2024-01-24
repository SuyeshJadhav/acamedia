import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Icon(
                    Icons.account_circle,
                    size: 220,
                  ),
                ),
                const Text(
                  "NAME NAME",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 40),
                ToggleSwitch(
                  minWidth: 65.0,
                  cornerRadius: 10.0,
                  minHeight: 50,
                  activeBgColors: [
                    [Color.fromARGB(255, 228, 245, 245)],
                    [Color.fromARGB(255, 38, 45, 37)]
                  ],
                  activeFgColor: Colors.black,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  icons: const [
                    Icons.notifications_active,
                    Icons.notifications_off
                  ],
                  iconSize: 50.0,
                  // labels: ['True', 'False'],
                  radiusStyle: true,
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                //   child: Text(
                //     "Notifications",
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                //   ),
                // ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(229, 245, 228, 1),
                        fixedSize: const Size(450, 65),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          size: 28,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        (Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
