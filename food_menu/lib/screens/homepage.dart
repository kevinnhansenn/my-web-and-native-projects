import 'package:flutter/material.dart';
import '../widgets/homepage_menu.dart';
import '../data/original.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      children: <Widget>[
        ...DUMMY_CATEGORIES.map((dummy) {
          return HomepageMenu(dummy.id, dummy.title, dummy.color);
        })
      ],
    );
  }
}
