//import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_downloader/image_downloader.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
//import 'package:wallpaper_manager/wallpaper_manager.dart';

// ignore: import_of_legacy_library_into_null_safe

// ignore: import_of_legacy_library_into_null_safe

// ignore: must_be_immutable
class FullScreen extends StatelessWidget {
  String imgUrl;

  FullScreen({super.key, required this.imgUrl});

  Future<void> setWallpaperFromFile(String imgUrl, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Downloading started..."),
      ),
    );
    try {
      var imgid = await ImageDownloader.downloadImage(imgUrl);
      if (imgid == null) {
        return;
      }
      //var filename = await ImageDownloader.findName(imgid);
      var path = await ImageDownloader.findPath(imgid);
      //var size = await ImageDownloader.findByteSize(imgid);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Download Successfully"),
          action: SnackBarAction(
            label: "Open",
            onPressed: () {
              OpenFile.open(path);
            },
          ),
        ),
      );
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error occured - $error"),
        ),
      );
    }
  }

  Future<void> setWallpaper(
      String imgUrl, BuildContext context, int location) async {
    try {
      // int location = WallpaperManager.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(imgUrl);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wallpaper set successfully"),
        ),
      );
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error occured - $error"),
        ),
      );
    }
  }

  showDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              backgroundColor: Colors.teal,
              alignment: Alignment.bottomCenter,
              children: [
                SimpleDialogOption(
                  onPressed: () => setWallpaper(
                      imgUrl, context, WallpaperManager.HOME_SCREEN),
                  child: const Text(
                    "Home Screen",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => setWallpaper(
                      imgUrl, context, WallpaperManager.LOCK_SCREEN),
                  child: const Text(
                    "Lock Screen",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => setWallpaper(
                      imgUrl, context, WallpaperManager.BOTH_SCREEN),
                  child: const Text(
                    "BothScreen",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () async {
                // setWallpaper(widget.imgUrl, context);
                showDialogBox(context);
              },
              child: const Text("Set Wallpaper"),
            ),
            Expanded(
              child: Container(
                width: 10,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await setWallpaperFromFile(imgUrl, context);
              },
              child: const Text("download Wallpaper"),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.fill)),
      ),
    );
  }
}
