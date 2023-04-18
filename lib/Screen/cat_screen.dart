import 'package:flutter/material.dart';
import 'package:wallpaper/Screen/full_screen.dart';
import 'package:wallpaper/controller/fetchapi.dart';
import 'package:wallpaper/model/photos_model.dart';
import 'package:wallpaper/widget/custom_appbar.dart';

// ignore: must_be_immutable
class CatScreen extends StatefulWidget {
  String catName;
  String catImgUrl;

  CatScreen({super.key, required this.catImgUrl, required this.catName});

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  late List<Photomodel> categoryResults;
  bool isLoading = true;
  // ignore: non_constant_identifier_names
  GetCatReWall() async {
    categoryResults = await Fetchapi.searchWallpaper(widget.catName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetCatReWall();
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.catImgUrl,
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black38,
                          ),
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned(
                          left: 120,
                          top: 60,
                          child: Text(
                            widget.catName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
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
                      itemCount: categoryResults.length,
                      itemBuilder: (context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imgUrl:
                                            categoryResults[index].imgsrc)));
                          },
                          child: Hero(
                            tag: categoryResults[index].imgsrc,
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
                                  categoryResults[index].imgsrc,
                                ),
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
