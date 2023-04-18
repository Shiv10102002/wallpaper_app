import 'package:flutter/material.dart';
import 'package:wallpaper/Screen/full_screen.dart';
import 'package:wallpaper/controller/fetchapi.dart';
import 'package:wallpaper/model/photos_model.dart';
import 'package:wallpaper/widget/custom_appbar.dart';
import 'package:wallpaper/widget/search_bar.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<Photomodel> searchResult = [];
  bool isLoading = true;
  GetSearchResult() async {
    searchResult = await Fetchapi.searchWallpaper(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetSearchResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const CustomAppBar(),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const SearchBar()),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 300,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgUrl: searchResult[index].imgsrc)));
                          },
                          child: Hero(
                            tag: searchResult[index].imgsrc,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(255, 226, 236, 234),
                              ),
                              height: 400,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                    height: 400,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    searchResult[index].imgsrc),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
