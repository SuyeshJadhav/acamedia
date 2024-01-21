import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
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
      body: Column(
        children: [
          const SizedBox(height: 50),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/p1.jpg'),
                  radius: 100.0,
                ),
                const SizedBox(height: 30),
                const Text(
                  'John Doe',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'john.doe@example.com',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: const Icon(FontAwesomeIcons.instagram),
                        onPressed: () async => {
                              await launchUrl(
                                  Uri.parse("https://instagram.com"),
                                  mode: LaunchMode.inAppWebView)
                            }),
                    IconButton(
                        icon: const Icon(FontAwesomeIcons.twitter),
                        onPressed: () async => {
                              await launchUrl(Uri.parse("https://twitter.com"),
                                  mode: LaunchMode.inAppWebView)
                            }),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
