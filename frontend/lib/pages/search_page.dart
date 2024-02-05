import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";

  void onChangedQuery(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          "Search Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromARGB(255, 248, 248, 248),
        child: Column(
          children: [
            SearchBar(onChangedQuery: onChangedQuery),
            Expanded(
              child: SearchResultsList(query: query),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChangedQuery;

  const SearchBar({super.key, required this.onChangedQuery});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Center(
          child: SizedBox(
            width: 350,
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

// ignore: must_be_immutable
class SearchResultsList extends StatelessWidget {
  final String query;

  List<ChatItem> names = [
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

class ChatItem {
  String name;
  List<String> tags;

  ChatItem({required this.name, required this.tags});
}
