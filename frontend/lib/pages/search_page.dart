import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: AppBar(
        //   title: const Text("Search Page"),
        //   backgroundColor: const Color.fromARGB(252, 252, 252, 252),
        //   elevation: 0,
        // ),
        body: Column(
      children: [
        SearchBar(),
        Expanded(
          child: Text("Results Here."),
        ),
      ],
    ));
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String query = "";

  void onChangedQuery(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: TextField(
          onChanged: onChangedQuery,
          decoration: const InputDecoration(
              labelText: "Search",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search)),
        ),
      ),
    );
  }
}
