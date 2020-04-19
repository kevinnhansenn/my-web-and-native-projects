import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './chat.dart';

class MainPageWhatsapp extends StatefulWidget {
  static const routeName = '/whatsapp-main';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPageWhatsapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(19, 4, 13, 0),
                  height: 45,
                  color: Color.fromRGBO(247, 247, 247, 1),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'asset/images/edit.png',
                        height: 28,
                      ),
                      Spacer(),
                      Image.asset(
                        'asset/images/write.png',
                        height: 28,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 43,
                  color: Color.fromRGBO(247, 247, 247, 1),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(18, 8, 0, 0),
                    child: Image.asset(
                      'asset/images/title.png',
                      height: 40,
                    ),
                  ),
                ),
                Container(
                  height: 62,
                  color: Color.fromRGBO(247, 247, 247, 1),
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Container(
                    child: Image.asset('asset/images/search1.png'),
                  ),
                ),
                Container(
                  height: 44,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  padding: EdgeInsets.fromLTRB(10, 0, 18, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        'asset/images/archived.png',
                        height: 43,
                      ),
                      Row(
                        children: <Widget>[
                          Text('0'),
                          Icon(Icons.navigate_next)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 44,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  padding: EdgeInsets.fromLTRB(14, 0, 13, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('asset/images/broadcast_list.png',
                          height: 34),
                      Image.asset(
                        'asset/images/new_group.png',
                        height: 34,
                      ),
                    ],
                  ),
                ),
                Chat(),
              ],
            ),

            // Opacity(
            //   opacity: 0.4,
            //   child: Image.asset(
            //     'asset/images/template.jpeg',
            //     fit: BoxFit.contain,
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 9,
        color: Color.fromRGBO(247, 247, 247, 1),
        child: Container(
          height: 50,
          child: Image.asset(
            'asset/images/navbar.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
