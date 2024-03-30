import 'package:flutter/material.dart';
import 'package:frontend/util/colors.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 5.0, bottom: 8.0),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.filter_list),
        onSelected: (String filter) {
          // Handle the selected filter
          print('Selected filter: $filter');
          // Implement logic to apply filter
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Filter 1',
            child: Text('Filter 1'),
          ),
          const PopupMenuItem<String>(
            value: 'Filter 2',
            child: Text('Filter 2'),
          ),
          const PopupMenuItem<String>(
            value: 'Filter 3',
            child: Text('Filter 3'),
          ),
          // Add more filters as needed
        ],
        tooltip: 'Filter options',
        elevation: 8, // Set elevation
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 12), // Set padding
        shape: RoundedRectangleBorder(
          // Set shape
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey), // Add border
        ),
        surfaceTintColor: AppColors.blueGreen,
      ),
    );
  }
}
