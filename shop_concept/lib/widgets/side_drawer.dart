import 'package:flutter/material.dart';
import '../screens/overview.dart';
import '../screens/order_page.dart';
import '../screens/manage_product.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.brown[200],
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'SIDEBAR',
                style: TextStyle(fontSize: 30),
              ),
              height: 280,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(20),
            ),
            ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(Overview.routeName),
            ),
            ListTile(
              title: Text('Order Page'),
              leading: Icon(Icons.shopping_cart),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(OrderPage.routeName),
            ),
            ListTile(
              title: Text('Manage Page'),
              leading: Icon(Icons.edit),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(ManageProduct.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
