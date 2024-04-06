import 'package:flutter/material.dart';
import 'package:frontend/util/colors.dart';

const List<String> roles = ['Student', 'Teacher', 'None'];
const List<String> branch = ['COMPS', 'IT', 'MECH', 'ETRX', 'None'];

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  String roleValue = 'None';
  String branchValue = 'None';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return FilterDialog(
                initialRole: roleValue,
                initialBranch: branchValue,
                onSelectionChanged: (String newRole, String newBranch) {
                  setState(() {
                    roleValue = newRole;
                    branchValue = newBranch;
                  });
                },
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

class FilterDialog extends StatefulWidget {
  final String initialRole;
  final String initialBranch;
  final Function(String, String) onSelectionChanged;

  const FilterDialog({
    super.key,
    required this.initialRole,
    required this.initialBranch,
    required this.onSelectionChanged,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late String selectedRole;
  late String selectedBranch;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.initialRole;
    selectedBranch = widget.initialBranch;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.blueGreen,
      insetPadding: const EdgeInsets.only(bottom: 50.0),
      contentPadding: const EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
      title: const Text(
        'Select Filters',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Role'),
            DropdownButton<String>(
              value: selectedRole,
              onChanged: (newValue) {
                setState(() {
                  selectedRole = newValue!;
                });
              },
              hint: const Text("Select a Role"),
              underline: Container(
                height: 2,
                color: AppColors.darkGreen, // Change underline color here
              ),
              items: roles.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Branch'),
            DropdownButton<String>(
              value: selectedBranch,
              onChanged: (newValue) {
                setState(() {
                  selectedBranch = newValue!;
                });
              },
              hint: const Text("Select a branch"),
              underline: Container(
                height: 2,
                color: AppColors.darkGreen, // Change underline color here
              ),
              items: branch.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            TextButton(
                onPressed: (() {
                  setState(() {
                    selectedRole = 'None';
                    selectedBranch = 'None';
                  });
                }),
                child: const Text('Reset')),
            const SizedBox(width: 35.0),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color.fromRGBO(203, 0, 0, 1)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onSelectionChanged(selectedRole, selectedBranch);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Color.fromRGBO(0, 71, 171, 1)),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
