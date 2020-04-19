import 'package:flutter/material.dart';
import './shoe_main.dart';

class ShoeDetail extends StatelessWidget {
  final Shoe shoe;

  ShoeDetail(this.shoe);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            width: size.width * 1.5,
            height: size.width * 1.5,
            top: -size.width / 2,
            right: -size.width / 3,
            child: Hero(
              tag: 'background_${shoe.name}',
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: shoe.color,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.1,
            left: 0,
            right: 0,
            child: Hero(
              tag: 'image_${shoe.name}',
              child: Image.asset(
                shoe.image,
                height: size.width * 0.9,
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: 50,
            child: Icon(
              Icons.favorite_border,
              size: 30,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 50,
            left: 30,
            child: BackButton(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
