import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChangedQuery;

  const SearchBox({super.key, required this.onChangedQuery});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Center(
          child: SizedBox(
            width: 340,
            height: 50,
            child: TextField(
              onChanged: onChangedQuery,
              decoration: const InputDecoration(
                labelText: "Search",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
