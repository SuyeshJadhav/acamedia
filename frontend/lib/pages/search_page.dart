import 'package:flutter/material.dart';
import '../widgets/search_widgets/filter_button.dart';
import '../widgets/search_widgets/search_bar.dart';
import '../widgets/search_widgets/search_results_list.dart';

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
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromARGB(255, 248, 248, 248),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchBox(onChangedQuery: onChangedQuery),
                ),
                const FilterButton(),
              ],
            ),
            Expanded(
              child: SearchResultsList(query: query),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatItem {
  String name;
  List<String> tags;

  ChatItem({required this.name, required this.tags});
}
