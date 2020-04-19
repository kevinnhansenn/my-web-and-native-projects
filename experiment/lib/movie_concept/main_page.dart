import 'dart:ui';

import 'package:flutter/material.dart';
import './detail_page.dart';

class Movie {
  final String url;
  final String title;

  const Movie({this.url, this.title});
}

const movies = [
  const Movie(
      url: 'https://i.ytimg.com/vi/YcHKrNMwWyQ/movieposter.jpg', title: 'Dora'),
  const Movie(
      url:
          'https://cdn.shopify.com/s/files/1/0057/3728/3618/products/5cae019e64c0ee10ead36a00e60f0137_eeb2d749-fdbe-46fd-978a-870cc7e0ddf7_500x.jpg?v=1573593942',
      title: 'Joker'),
  const Movie(
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRAog3B6UEzMDOhehRXmjQbV2qYGOHYMh3jGGwqL7zwnwRJ6YyD',
      title: 'Predator'),
  const Movie(
    url:
        'https://images-na.ssl-images-amazon.com/images/I/719fSnntGgL._AC_SL1500_.jpg',
    title: 'Anabelle',
  ),
];

class MainPageMovie extends StatefulWidget {
  static const routeName = '/movie-concept';
  @override
  _MainPageTrialState createState() => _MainPageTrialState();
}

class _MainPageTrialState extends State<MainPageMovie> {
  PageController _controller = PageController(viewportFraction: 0.6);
  ValueNotifier _notifier = ValueNotifier<double>(0.0);

  void _listener() {
    _notifier.value = _controller.page;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controller.addListener(_listener));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: _notifier,
            builder: ((_, value, __) => AnimatedSwitcher(
                  duration: Duration(
                    seconds: 3,
                  ),
                  key: ValueKey(value.floor()),
                  child: SizedBox.expand(
                    child: Opacity(
                      opacity: 0.6,
                      child: Image.network(
                        movies[value.floor()].url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              height: size.height / 2.0,
              width: size.width,
              child: PageView.builder(
                  controller: _controller,
                  itemCount: movies.length,
                  itemBuilder: (ctx, index) {
                    final lerp =
                        lerpDouble(0, 1, (index - _notifier.value).abs());
                    final opacity =
                        1 - lerpDouble(0, 0.4, (index - _notifier.value).abs());
                    final transform = Matrix4.identity();
                    transform.translate(0.0, lerp * 50);
                    return Opacity(
                      opacity: opacity,
                      child: Transform(
                        transform: transform,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap: () => Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: ((_, animation, __) =>
                                        FadeTransition(
                                          opacity: animation,
                                          child: DetailPage(movies[index]),
                                        )),
                                  ),
                                ),
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ClipRRect(
                                    child: Hero(
                                      tag: movies[index].title,
                                      child: Image.network(
                                        movies[index].url,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
