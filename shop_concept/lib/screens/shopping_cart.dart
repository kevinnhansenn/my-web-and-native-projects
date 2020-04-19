import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/cart_tile.dart';
import '../providers/order.dart';

class ShoppingCart extends StatelessWidget {
  static const routeName = '/shopping-cart';

  @override
  Widget build(BuildContext context) {
    CartItem cart = Provider.of<CartItem>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 10,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'TOTAL',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalPrice}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.brown,
                  ),
                  FlatButton(
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      OrderItem order =
                          Provider.of<OrderItem>(context, listen: false);
                      order.addOrder(cart.totalPrice, cart.items);

                      cart.clearCart();
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Swipe left to delete items',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) => CartTile(
                title: cart.items.values.toList()[index].title,
                quantity: cart.items.values.toList()[index].quantity,
                price: cart.items.values.toList()[index].price,
                id: cart.items.keys.toList()[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
