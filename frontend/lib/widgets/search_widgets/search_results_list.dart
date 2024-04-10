import 'package:flutter/material.dart';
import 'package:frontend/services/user_service.dart';

class SearchResultsList extends StatefulWidget {
  final String query, role, branch;

  SearchResultsList(
      {super.key,
      required this.query,
      required this.role,
      required this.branch});

  @override
  State<SearchResultsList> createState() => _SearchResultsListState();
}

class _SearchResultsListState extends State<SearchResultsList> {
  // final List<ChatItem> names = [
  //   ChatItem(name: "John", tags: ["Math", "Physics", "Engineering"]),
  //   ChatItem(name: "Alice", tags: ["Physics", "Chemistry", "Medical"]),
  // ];
  List<dynamic> results = [];

  // Basic search logic
  void getSearchResults(String query, role, branch) async {
    final searchMap = await userService.searchUserList(query, role, branch);
    query = query.toLowerCase();
    if (searchMap != null) {
      setState(() {
        results = searchMap;
      });
    }
    // return names.where((item) {
    //   return item.name.toLowerCase().contains(query) ||
    //       item.tags.any((tag) => tag.toLowerCase().contains(query));
    // }).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchResults(widget.query, widget.role, widget.branch);
    print(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    // final results = getSearchResults(widget.query);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(results[index]['fname']));
      },
    );
  }
}
