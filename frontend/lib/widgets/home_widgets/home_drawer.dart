import 'package:flutter/material.dart';
import 'package:frontend/util/colors.dart';
import 'package:frontend/widgets/home_widgets/drawer_list.dart';

class HomeDrawer extends StatelessWidget {
  final String fname, lname;
  const HomeDrawer(this.fname, this.lname, {super.key});

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
          children: [
            DrawerList(fname, lname),
          ],
        ),
      ),
    );
  }
}
