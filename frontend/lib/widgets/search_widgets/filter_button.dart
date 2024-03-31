import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Select Filter'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Filter 1'),
                        onTap: () {
                          // Handle selection of Filter 1
                          Navigator.of(context).pop('Filter 1');
                        },
                      ),
                      ListTile(
                        title: Text('Filter 2'),
                        onTap: () {
                          // Handle selection of Filter 2
                          Navigator.of(context).pop('Filter 2');
                        },
                      ),
                      // Add more filters as needed
                    ],
                  ),
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.tune), // Use the tune icon
        color: Colors.black,
      ),
    );
  }
}
