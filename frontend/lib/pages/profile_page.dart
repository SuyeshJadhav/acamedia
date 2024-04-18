import 'package:flutter/material.dart';
import 'package:frontend/helpers/helper_functions.dart';
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
                name = ('$firstName $lastName')
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
                      name.isNotEmpty
                          ? name
                              .split(' ')
                              .map((namePart) => namePart[0].toUpperCase())
                              .join('')
                          : '',
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
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                const LogoutBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
