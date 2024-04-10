import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchBox extends StatelessWidget {
  final ValueChanged<String> onChangedQuery;

  const SearchBox({super.key, required this.onChangedQuery});

  @override
  Widget build(BuildContext context) {
    final _searchTextController = TextEditingController();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Center(
          child: SizedBox(
            width: 340,
            height: 50,
            child: TextField(
              controller: _searchTextController,
              onSubmitted: onChangedQuery,
              decoration: InputDecoration(
                labelText: "Search",
                border: const OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: () {
                    onChangedQuery(_searchTextController.text);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
