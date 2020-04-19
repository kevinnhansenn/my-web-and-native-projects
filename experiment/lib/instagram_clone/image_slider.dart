import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  final List<String> dashboard;

  ImageSlider(this.dashboard);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      height: 414,
      items: [
        ...dashboard.map((img) {
          return Image.asset(img, fit: BoxFit.contain);
        })
      ],
      viewportFraction: 1.0,
    );
  }
}
