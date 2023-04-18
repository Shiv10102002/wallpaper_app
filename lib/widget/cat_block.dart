import 'package:flutter/material.dart';
import 'package:wallpaper/Screen/cat_screen.dart';

class CatBlock extends StatelessWidget {
  String categoryName;
  String categoryImgSrc;
  CatBlock(
      {super.key, required this.categoryImgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CatScreen(
                    catImgUrl: categoryImgSrc, catName: categoryName)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                height: 50,
                width: 100,
                categoryImgSrc,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black26),
            ),
            Positioned(
                left: 25,
                top: 15,
                child: Text(
                  categoryName,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
