import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper/model/category_model.dart';
import 'package:wallpaper/model/photos_model.dart';

class Fetchapi {
  static List<Photomodel> trendingWallpaper = [];
  static List<Photomodel> searchWallList = [];
  static List<CategoryModel> cateogryModelList = [];
  static String _apiKey =
      "DyxA1AN0CxApoPClNm4h8d0qTEzxU3DwWAFc1qUKt17DZbKG5LZBxJRy";

  static Future<List<Photomodel>> fetchapi() async {
    await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?&per_page=76&page=1"),
        headers: {"Authorization": _apiKey}).then((value) {
      print("RESPONSE REPORT");
      print(value.body);
      Map<String, dynamic> jsondata = jsonDecode(value.body);
      List photos = jsondata["photos"];
      photos.forEach((element) {
        trendingWallpaper.add(Photomodel.fromApiToApp(element));
      });
    });
    return trendingWallpaper;
  }

  static Future<List<Photomodel>> searchWallpaper(qury) async {
    await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/search?query=$qury&per_page=70&page=1"),
      headers: {
        "Authorization": _apiKey,
      },
    ).then((value) {
      Map<String, dynamic> jsondata = jsonDecode(value.body);
      List photos = jsondata["photos"];
      searchWallList.clear();
      photos.forEach((element) {
        searchWallList.add(Photomodel.fromApiToApp(element));
      });
    });
    return searchWallList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers",
      "Cartoon",
      "Mountain",
      "Emoji",
      "Animals",
      "Sunset",
      "Beach"
          "Ocean",
      "Moon",
      "Space",
      "Galaxy",
      "Cloud",
      "Stars",
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      Photomodel photoModel =
          (await searchWallpaper(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgsrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgsrc, catName: catName));
    });

    return cateogryModelList;
  }
}
