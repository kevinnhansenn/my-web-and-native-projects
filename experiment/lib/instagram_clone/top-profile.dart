import 'package:flutter/material.dart';

class TopProfile extends StatelessWidget {
  final String name;
  final String url;
  final bool custom;

  TopProfile(this.name, this.url, this.custom);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: custom ? 24 : 20),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.orange],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )),
            child: CircleAvatar(
              backgroundImage: AssetImage(url),
              radius: 29,
            ),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }
}
