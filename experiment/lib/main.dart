import 'package:flutter/material.dart';
import './list_controller//list_controller.dart';
import './ball_shop/layout_page_controller.dart';
import './shoe_shop/shoe_main.dart';
import './instagram_clone/main_page.dart';
import './whatsapp_clone/whatsapp_main.dart';
import './movie_concept/main_page.dart';
import './trial/main_trial.dart';
import './sqflite_crud/main_page.dart';

// import './camera_map_sql//main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      // home: MainPageSQL(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        ListController.routeName: (ctx) => ListController(),
        LayoutPageController.routeName: (ctx) => LayoutPageController(),
        ShoeShop.routeName: (ctx) => ShoeShop(),
        MainPageInstagram.routeName: (ctx) => MainPageInstagram(),
        MainPageWhatsapp.routeName: (ctx) => MainPageWhatsapp(),
        MainPageMovie.routeName: (ctx) => MainPageMovie(),
        MainTrial.routeName: (ctx) => MainTrial(),
        MainPageSQL.routeName: (ctx) => MainPageSQL(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Topics'),
          ),
          body: Container(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('List Controller'),
                  onTap: () =>
                      Navigator.pushNamed(context, ListController.routeName),
                ),
                ListTile(
                  title: Text('Ball Shop'),
                  onTap: () => Navigator.pushNamed(
                      context, LayoutPageController.routeName),
                ),
                ListTile(
                  title: Text('Shoe Shop'),
                  onTap: () => Navigator.pushNamed(context, ShoeShop.routeName),
                ),
                ListTile(
                  title: Text('Instagram Clone'),
                  onTap: () =>
                      Navigator.pushNamed(context, MainPageInstagram.routeName),
                ),
                ListTile(
                  title: Text('WhatsApp Clone'),
                  onTap: () =>
                      Navigator.pushNamed(context, MainPageWhatsapp.routeName),
                ),
                ListTile(
                  title: Text('Movie Concept'),
                  onTap: () =>
                      Navigator.pushNamed(context, MainPageMovie.routeName),
                ),
                ListTile(
                  title: Text('Trial'),
                  onTap: () =>
                      Navigator.pushNamed(context, MainTrial.routeName),
                ),
                ListTile(
                  title: Text('SQL CRUD'),
                  onTap: () =>
                      Navigator.pushNamed(context, MainPageSQL.routeName),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Text('Hi Flutter!'),
      ),
    );
  }
}
