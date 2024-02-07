import 'package:flutter/material.dart';
import 'package:frontend/pages/call_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/search_page.dart';
import 'package:frontend/widgets/home_widgets/drawer_list_title.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 13.0, bottom: 11),
          child: ListTile(
            title: const Text("Name Name"),
            leading: GestureDetector(
              onTap: () {
                // Handle profile icon tap, navigate to profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const SizedBox(
                width: 60.0, // Adjust the width as needed
                child: CircleAvatar(
                  foregroundImage: AssetImage('lib/assets/p1.jpg'),
                  radius: 30.0,
                ),
              ),
            ),
          ),
        ),
        DrawerListTile(
          iconData: Icons.search_rounded,
          label: "Search",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            );
          },
        ),
        DrawerListTile(
          iconData: Icons.call_rounded,
          label: "Calls",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CallPage(),
              ),
            );
          },
        ),
        DrawerListTile(
          iconData: Icons.settings_rounded,
          label: "Settings",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
