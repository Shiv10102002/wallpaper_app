import 'package:flutter/material.dart';
import 'package:wallpaper/Screen/search_screen.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 237, 237),
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(query: searchController.text))),
              controller: searchController,
              decoration: const InputDecoration(
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: "Search Wallpaper",
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          //InkWell(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //        builder: (context) => SearchScreen(
          //        query: _searchController.text,
          //    ),
          //),
          // );
          //},
          //child: const Icon(
          // Icons.search,
          //  color: Colors.grey,
          // ),
          // ),
        ],
      ),
    );
  }
}
