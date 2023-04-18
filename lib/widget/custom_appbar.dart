import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          text: "Wallpaper ",
          style: TextStyle(
              color: Color.fromARGB(255, 230, 237, 228),
              fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: "Guru",
              style: TextStyle(
                  color: Colors.yellowAccent, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
