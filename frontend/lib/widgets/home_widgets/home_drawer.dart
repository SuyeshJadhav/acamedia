import 'package:flutter/material.dart';
import 'package:frontend/util/colors.dart';
import 'package:frontend/widgets/home_widgets/drawer_list.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // Adjust the radius as needed
      ),
      child: Container(
        color: AppColors.lightGreen,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: const [
            DrawerList(),
          ],
        ),
      ),
    );
  }
}
