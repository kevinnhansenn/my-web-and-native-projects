import 'package:flutter/material.dart';
import '../screens/tab_screen.dart';
import '../screens/settings.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget showTile(String title, IconData icon, String route) {
      return ListTile(
        contentPadding: EdgeInsets.only(left: 70, top: 20),
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(route);
        },
        leading: Icon(icon),
      );
    }

    return Drawer(
      elevation: 10,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.cyan,
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Text(
                'Sidebar',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            showTile('Homepage', Icons.access_time, TabScreen.routeName),
            showTile('Settings', Icons.settings, Settings.routeName),
          ],
        ),
      ),
    );
  }
}
