import 'package:flutter/material.dart';
class ImageDisplay extends StatelessWidget {
  String imageDir;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(imageDir)),
        ),
    );
  }

  ImageDisplay(String imageDir) {
    this.imageDir = imageDir;
  }
}
