import 'package:flutter/material.dart';
import './feed_body.dart';
// import './video_feed.dart';

class MyHomePageInstagram extends StatefulWidget {
  static const routeName = '/instagram-clone';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageInstagram> {
  Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return Transform(
      // Transform widget
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0011) // perspective
        ..rotateX(_offset.dy)
        ..rotateY(_offset.dx),
      alignment: FractionalOffset.center,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                // VideoFeed(),
                FeedBody(),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          title: Container(
            padding: EdgeInsets.only(top: 8),
            height: 40,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      'asset/images/camera.png',
                      height: 34,
                    ),
                    Spacer(),
                    Image.asset(
                      'asset/images/tv.png',
                      height: 34,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'asset/images/navt.png',
                      height: 34,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'asset/images/instagram.png',
                      height: 34,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Color.fromRGBO(250, 250, 250, 1),
            height: 44,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(4, 8, 4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset('asset/images/home.png'),
                Image.asset('asset/images/search.png'),
                GestureDetector(
                  onPanUpdate: (details) =>
                      setState(() => _offset += details.delta),
                  onDoubleTap: () => setState(() => _offset = Offset.zero),
                  child: Image.asset('asset/images/plus.png'),
                ),
                Image.asset('asset/images/fav.png'),
                Image.asset('asset/images/profile.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
