import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/shopping_cart.dart';

import '../widgets/gridview_builder.dart';
import '../widgets/side_drawer.dart';

enum Filter {
  All,
  Favorite,
}

class Overview extends StatefulWidget {
  static const routeName = '/overview';

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  bool _showOnlyFavs = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SHOP'),
        actions: <Widget>[
          Chip(
            label: Consumer<CartItem>(
              builder: (ctx, item, child) => Text(
                item.itemCount.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: Colors.white,
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(ShoppingCart.routeName),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Show All'),
                value: Filter.All,
              ),
              PopupMenuItem(
                child: Text('Show Favorite Only'),
                value: Filter.Favorite,
              ),
            ],
            onSelected: (index) {
              setState(() {
                if (index == Filter.Favorite) {
                  _showOnlyFavs = true;
                } else {
                  _showOnlyFavs = false;
                }
              });
            },
          )
        ],
      ),
      drawer: SideDrawer(),
      body: GridViewBuilder(_showOnlyFavs),
    );
  }
}
