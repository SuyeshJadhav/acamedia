import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 65.0,
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      title: const Text(
        'Chats',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
        child: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
