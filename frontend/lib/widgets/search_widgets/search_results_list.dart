import 'package:flutter/material.dart';
import 'package:frontend/pages/search_page.dart';

class SearchResultsList extends StatelessWidget {
  final String query;

  final List<ChatItem> names = [
    ChatItem(name: "John", tags: ["Math", "Physics", "Engineering"]),
    ChatItem(name: "Alice", tags: ["Physics", "Chemistry", "Medical"]),
  ];

  SearchResultsList({super.key, required this.query});

  // Basic search logic
  List<ChatItem> getSearchResults(String query) {
    query = query.toLowerCase();
    return names.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.tags.any((tag) => tag.toLowerCase().contains(query));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = getSearchResults(query);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(results[index].name));
      },
    );
  }
}
