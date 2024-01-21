import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
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
          child: const Column(
            children: [
              SearchBar(),
              Expanded(
                child: Text("Results Here."),
              ),
            ],
          ),
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
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
        ),
      ),
    );
  }
}
