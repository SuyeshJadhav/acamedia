import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Function() onTap;

  const DrawerListTile({
    super.key,
    required this.iconData,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
            size: 24.0,
          ),
          const SizedBox(width: 15.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text(label),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
