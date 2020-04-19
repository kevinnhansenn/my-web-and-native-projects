import 'package:flutter/material.dart';
import './layout_page_controller.dart';

class Detail extends StatelessWidget {
  final Ball ball;

  Detail(this.ball);

  @override
  Widget build(BuildContext context) {
    final ctx = MediaQuery.of(context).size;
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: 'container_${ball.name}',
                child: Container(
                  width: ctx.width * 0.5,
                  height: ctx.height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30)),
                    color: ball.color,
                  ),
                ),
              ),
            ),
            Positioned(
              child: BackButton(
                color: Colors.black,
              ),
              top: 50,
              left: 20,
            ),
            Positioned(
              top: ctx.height * 0.20,
              right: 80,
              child: Hero(
                tag: 'image_${ball.name}',
                child: Image.asset(
                  ball.image,
                  width: ctx.width / 2,
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 30,
              child: Hero(
                tag: 'text_${ball.name}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    ball.name.split(" ").join('\n'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
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
