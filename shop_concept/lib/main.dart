import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/order.dart';

import './screens/overview.dart';
import './screens/product_detail.dart';
import './screens/shopping_cart.dart';
import './screens/order_page.dart';
import './screens/manage_product.dart';
import './screens/add_product.dart';
import './screens/auth-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: CartItem()),
        ChangeNotifierProvider.value(value: OrderItem()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          Overview.routeName: (ctx) => Overview(),
          ProductDetail.routeName: (ctx) => ProductDetail(),
          ShoppingCart.routeName: (ctx) => ShoppingCart(),
          OrderPage.routeName: (ctx) => OrderPage(),
          ManageProduct.routeName: (ctx) => ManageProduct(),
          AddProduct.routeName: (ctx) => AddProduct(),
        },
      ),
    );
  }
}
