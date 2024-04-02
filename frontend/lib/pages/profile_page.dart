import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../widgets/profile_widgets/logout_btn.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool notificationsEnabled = true;
  Map<String, dynamic> user = {};
  String name = '', branch = '', email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await HelperFunctions.getUserData().then((value) => {
          if (value != null)
            {
              setState(() {
                user = value;
                String firstName =
                    user['fname'] ?? ''; // Null check for first name
                String lastName =
                    user['lname'] ?? ''; // Null check for last name
                name = (firstName + ' ' + lastName)
                    .toUpperCase(); // Concatenate and convert to uppercase
                branch = user['branch'] ?? ''; // Null check for branch
                email = user['email'] ?? ''; // Null check for email
                branch = branch.toUpperCase(); // Convert branch to uppercase
              })
            }
        });
  }

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
          "Profile",
          style: TextStyle(color: Colors.black, fontSize: 20.0),
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
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 100.0,
                    child: Text(
                      name.isNotEmpty ? name[0] : '',
                      style: const TextStyle(
                          fontSize: 45, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Email : $email",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Text(
                  "Branch : $branch",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Notification",
                              style: TextStyle(
                                color: Color.fromRGBO(38, 45, 37, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ToggleSwitch(
                              minWidth: 40.0,
                              cornerRadius: 10.0,
                              minHeight: 35,
                              activeBgColors: const [
                                [Color.fromARGB(255, 228, 245, 245)],
                                [Color.fromARGB(255, 42, 82, 81)]
                              ],
                              activeFgColor: Colors.black,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              initialLabelIndex: notificationsEnabled ? 0 : 1,
                              totalSwitches: 2,
                              icons: const [
                                Icons.notifications_active,
                                Icons.notifications_off
                              ],
                              iconSize: 24.0,
                              radiusStyle: true,
                              onToggle: (index) {
                                setState(() {
                                  notificationsEnabled = index == 0;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const LogoutBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
