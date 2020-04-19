import 'package:flutter/material.dart';

class HomepageMenu extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  void chooseMenu(BuildContext ctx) {
    // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    //   return DetailMenu(id, title);
    // }));
    Navigator.of(ctx).pushNamed('/detail-menu', arguments: {
      'id': id,
      'title': title,
    });
  }

  HomepageMenu(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        chooseMenu(context);
      },
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
            child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        )),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.3), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
