import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

import './shoe_detail.dart';

const bottomBackgroundColor = Color(0xFFF1F2F7);
const brands = ['Nike', 'Adidas', 'Jordan', 'Puma', 'Reebok'];
const sideBrands = ['New', 'Featured', 'Upcoming'];
const marginSide = 14.0;
const leftItemSeparator = const SizedBox(
  width: 30,
);

class Shoe {
  final String name;
  final String image;
  final double price;
  final Color color;

  const Shoe({
    this.name,
    this.image,
    this.price,
    this.color,
  });
}

const shoes = [
  const Shoe(
      name: 'NIKE EPICT-REACT',
      price: 130.00,
      image: 'images/shoes/1.png',
      color: Color(0xFF5574b9)),
  const Shoe(
      name: 'NIKE AIR-MAX',
      price: 130.00,
      image: 'images/shoes/2.png',
      color: Color(0xFF52b8c3)),
  const Shoe(
      name: 'NIKE AIR-270',
      price: 150.00,
      image: 'images/shoes/3.png',
      color: Color(0xFFE3AD9B)),
  const Shoe(
      name: 'NIKE EPICT-REACTII',
      price: 160.00,
      image: 'images/shoes/4.png',
      color: Color(0xFF444547)),
];

const shoesBottom = [
  const Shoe(name: 'NIKE AIR-MAX', price: 170.00, image: 'images/shoes/3.png'),
  const Shoe(
      name: 'NIKE AIR FORCE', price: 130.00, image: 'images/shoes/4.png'),
];

class ShoeShop extends StatefulWidget {
  static const routeName = '/shoe-shop';
  @override
  _ShoeShopState createState() => _ShoeShopState();
}

class _ShoeShopState extends State<ShoeShop> {
  PageController _controller = PageController();
  ValueNotifier _notifier = ValueNotifier<double>(0.0);

  void _listener() {
    _notifier.value = _controller.page;
    setState(() {});
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    _controller.addListener(_listener);
    // });

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomBackgroundColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey[400],
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarms),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessible),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(''),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopBar(),
            MenuBar(
              brands: brands,
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: MenuBar(
                        brands: sideBrands,
                      ),
                    ),
                  ),
                  PageView.builder(
                      controller: _controller,
                      itemCount: shoes.length,
                      itemBuilder: (ctx, index) {
                        final t = (index - _notifier.value);
                        final rotationY = lerpDouble(0, 90, t);
                        final translationX = lerpDouble(0, -50, t);
                        final scale = lerpDouble(0, -0.2, t);
                        final transform = Matrix4.identity();
                        transform.setEntry(3, 2, 0.001);
                        transform.rotateY(vector.radians(rotationY));
                        transform.translate(translationX);
                        transform.scale(1 - scale);

                        final rotationZShoe = lerpDouble(0, -45, t);
                        final translationXShoe = lerpDouble(0, 150, t);
                        final transformShoe = Matrix4.identity();
                        transformShoe.rotateZ(vector.radians(rotationZShoe));
                        transformShoe.translate(translationXShoe);

                        return InkWell(
                          onTap: () => Navigator.of(context).push(
                              PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 800),
                                  pageBuilder: (_, animation, __) =>
                                      FadeTransition(
                                        opacity: animation,
                                        child: ShoeDetail(shoes[index]),
                                      ))),
                          child: Stack(
                            children: <Widget>[
                              Transform(
                                transform: transform,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width / 4.5,
                                    vertical: 20,
                                  ),
                                  child: Center(
                                    child: Hero(
                                      tag: 'background_${shoes[index].name}',
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        color: shoes[index].color,
                                        child: SizedBox.expand(
                                          child: Stack(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15, left: 20),
                                                child: Text(
                                                  shoes[index]
                                                      .name
                                                      .split(" ")
                                                      .join('\n'),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Positioned(
                                                right: 20,
                                                top: 20,
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Positioned(
                                                right: 20,
                                                bottom: 20,
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Transform(
                                  transform: transformShoe,
                                  child: Hero(
                                    tag: 'image_${shoes[index].name}',
                                    child: Image.asset(
                                      shoes[index].image,
                                      width: size.width / 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
            NewArrival(size: size)
          ],
        ),
      ),
    );
  }
}

class NewArrival extends StatelessWidget {
  const NewArrival({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      color: Colors.grey[300],
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          ...shoesBottom.map(
            (shoe) => Expanded(
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox.expand(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 20,
                        right: 30,
                        left: 30,
                        child: Column(
                          children: <Widget>[
                            Text(shoe.name),
                            Text('\$${shoe.price.toString()}'),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  right: 8.0,
                                ),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Transform.scale(
                              child: Transform.rotate(
                                angle: 0.4,
                                child: Transform.translate(
                                  child: Image.asset(shoe.image),
                                  offset: const Offset(10, -15),
                                ),
                              ),
                              scale: 0.8,
                            )
                          ],
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Container(
                          decoration: ShapeDecoration(
                            color: Colors.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            'New Arrival',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          Text(
            'Discover',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.search),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }
}

class MenuBar extends StatelessWidget {
  final List<String> brands;
  const MenuBar({
    Key key,
    this.brands,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          itemBuilder: (ctx, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              brands[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: index == 0 ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
