import 'package:flutter/material.dart';
import 'package:wallpaper/Screen/full_screen.dart';
import 'package:wallpaper/controller/fetchapi.dart';
import 'package:wallpaper/model/category_model.dart';
import 'package:wallpaper/model/photos_model.dart';
import 'package:wallpaper/widget/cat_block.dart';
import 'package:wallpaper/widget/custom_appbar.dart';
import 'package:wallpaper/widget/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Photomodel> trendingWallList;
  // ignore: non_constant_identifier_names
  late List<CategoryModel> CatList;
  bool isLoading = true;

  // ignore: non_constant_identifier_names
  GetCatDetails() async {
    CatList = await Fetchapi.getCategoriesList();
    // print("GETTTING CAT MOD LIST");
    // print(CatList);
    setState(() {
      CatList = CatList;
    });
  }

  // ignore: non_constant_identifier_names
  GetTrandingWallPaper() async {
    trendingWallList = await Fetchapi.fetchapi();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    GetTrandingWallPaper();
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
                  SearchBar(),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: CatList.length,
                        itemBuilder: (context, index) => CatBlock(
                          categoryImgSrc: CatList[index].catImgUrl,
                          categoryName: CatList[index].catName,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    height: 700,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 300,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                        ),
                        itemCount: trendingWallList.length,
                        itemBuilder: (context, index) => GridTile(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreen(
                                          imgUrl:
                                              trendingWallList[index].imgsrc)));
                            },
                            child: Hero(
                              tag: trendingWallList[index].imgsrc,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      const Color.fromARGB(255, 226, 236, 234),
                                ),
                                height: 400,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    height: 400,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    trendingWallList[index].imgsrc,
                                  ),
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
