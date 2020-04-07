import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  String imageDir;

  ImageDisplay(String imageDir) {
    this.imageDir = imageDir;
  }

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
}
