import 'package:flutter/material.dart';
import 'dart:ui';
import './detail.dart';

class Ball {
  final int price;
  final String model;
  final String name;
  final String image;
  final Color color;
  final Color textColor;

  const Ball({
    this.price,
    this.model,
    this.name,
    this.image,
    this.color,
    this.textColor,
  });
}

const header = [
  'Soccer Balls',
  'Volley Balls',
  'Basket Balls',
  'Dodge Balls',
];
const footer = [
  'Size 3',
  'Size 4',
  'Size 5',
];
String chosen = 'Size 4';

//24,30,31
const balls = [
  const Ball(
      price: 14,
      name: 'Nike Strike',
      model: 'Armory Black',
      color: Colors.black,
      textColor: Colors.white,
      image: 'images/balls/ball1.png'),
  const Ball(
      price: 30,
      name: 'UEFA CL 18',
      model: 'UEFA blue',
      color: Color(0xFF07205A),
      textColor: Colors.white,
      image: 'images/balls/ball2.png'),
  const Ball(
      price: 21,
      name: 'Nike Aven',
      model: 'UEFA Turquoise',
      color: Color(0xFF6EE897),
      textColor: Colors.black,
      image: 'images/balls/ball3.png'),
  const Ball(
      price: 50,
      name: 'Adidas beau jeu',
      model: 'UEFA 2016',
      color: Color(0xFF743AD6),
      textColor: Colors.white,
      image: 'images/balls/ball4.png'),
];

class LayoutPageController extends StatefulWidget {
  static const routeName = '/page-controller';

  @override
  _LayoutPageControllerState createState() => _LayoutPageControllerState();
}

class _LayoutPageControllerState extends State<LayoutPageController> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final ValueNotifier _pageNotifier = ValueNotifier<double>(0.0);
  final ValueNotifier _priceNotifier = ValueNotifier<int>(balls.first.price);

  int lastPrice;

  void listener() {
    _pageNotifier.value = _pageController.page;
    // setState(() {});
  }

  @override
  void initState() {
    _pageController.addListener(listener);
    lastPrice = balls.first.price;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(listener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[200],
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text(''),
            ),
          ]),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  top: 30.0,
                  bottom: 20.0,
                ),
                child: Text(
                  'Sports Center',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 18.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 40,
                ),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                  itemCount: header.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => Container(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                header[index],
                                style: TextStyle(
                                  color:
                                      index == 0 ? Colors.black : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
            ),
          ),
          Divider(),
          Container(
            height: 500,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 50,
                  bottom: 200,
                  child: ValueListenableBuilder(
                    valueListenable: _priceNotifier,
                    builder: ((ctx, value, _) => TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 800),
                          tween: IntTween(begin: lastPrice, end: value),
                          builder: (ctx, value, _) => Text(
                            '\$$value',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey,
                            ),
                          ),
                        )),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _pageNotifier,
                  builder: (ctx, value, child) => PageView.builder(
                    itemCount: balls.length,
                    controller: _pageController,
                    onPageChanged: (index) {
                      _priceNotifier.value = balls[index].price;
                      lastPrice = balls[index].price;
                    },
                    itemBuilder: (ctx, pos) {
                      double opacity = lerpDouble(
                          1.0, 0.0, (pos - _pageNotifier.value).abs());
                      opacity = opacity < 0.0 ? 0.0 : opacity;

                      return Container(
                        child: Opacity(
                          opacity: opacity,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    pageBuilder: (_, animation, __) =>
                                        FadeTransition(
                                          opacity: animation,
                                          child: Detail(balls[pos]),
                                        ))),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Hero(
                                        tag: 'text_${balls[pos].name}',
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            balls[pos]
                                                .name
                                                .split(" ")
                                                .join('\n'),
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 20,
                                  bottom: 20,
                                  child: Hero(
                                    tag: 'container_${balls[pos].name}',
                                    child: Container(
                                      width: 190,
                                      decoration: BoxDecoration(
                                        color: balls[pos].color,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Transform.scale(
                                    scale: opacity,
                                    child: Hero(
                                      tag: 'image_${balls[pos].name}',
                                      child: Image.asset(
                                        balls[pos].image,
                                        width:
                                            MediaQuery.of(ctx).size.width / 2.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              ...footer.map(
                (item) => Expanded(
                  child: InkWell(
                    onTap: (() {
                      setState(() {
                        chosen = item;
                      });
                    }),
                    child: Container(
                      height: 80,
                      child: Card(
                        elevation: chosen == item ? 0 : 8,
                        child: Center(
                            child: Text(
                          item,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
