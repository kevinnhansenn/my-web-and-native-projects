import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  final Widget item;

  Feed(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 55,
            padding: EdgeInsets.fromLTRB(7, 7, 0, 7),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.orange],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      )),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('asset/photos/person2.jpg'),
                    radius: 17,
                  ),
                ),
                Text(
                  'andreabocelli',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: null,
                )
              ],
            ),
          ),
          // ImageSlider(dashboard),
          // VideoFeed(),
          item,
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 8, 0),
            height: 43,
            color: Color.fromRGBO(255, 255, 255, 1),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'asset/images/love.png',
                  height: 35,
                ),
                SizedBox(width: 3),
                Image.asset(
                  'asset/images/chat.png',
                  height: 35,
                ),
                SizedBox(width: 11),
                Image.asset(
                  'asset/images/navb.png',
                  height: 35,
                ),
                Spacer(),
                Image.asset(
                  'asset/images/mark.png',
                  height: 36,
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 4, 0, 0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 6),
                  width: 40,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 20,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('asset/photos/person2.jpg'),
                          radius: 10,
                        ),
                      ),
                      Positioned(
                        left: 10,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('asset/photos/person3.jpg'),
                          radius: 10,
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('asset/photos/person4.jpg'),
                        radius: 10,
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Liked by ',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'andreabocelli',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: '8 others',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                )
                // Text(
                //   'Liked by andreabocelli and 8 others',
                //   style: TextStyle(fontSize: 13),
                // ),
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            padding: EdgeInsets.fromLTRB(15, 6, 0, 0),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'andreabocelli ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          'This is a very very long text to dexcribe image above. Sometimes it could be more than three or four lines... more'),
                ],
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
          Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            padding: EdgeInsets.fromLTRB(15, 9, 0, 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('asset/photos/YourStory.jpg'),
                  radius: 13,
                ),
                Container(
                  child: Text(
                    'Add a comment...',
                    style: TextStyle(fontSize: 14),
                  ),
                  margin: EdgeInsets.only(left: 11),
                )
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(18, 8, 0, 0),
            height: 33,
            child: Row(
              children: <Widget>[
                Text(
                  '1 HOUR AGO',
                  style: TextStyle(fontSize: 8),
                ),
                SizedBox(
                  width: 13,
                ),
                Text(
                  'SEE TRANSLATION',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
