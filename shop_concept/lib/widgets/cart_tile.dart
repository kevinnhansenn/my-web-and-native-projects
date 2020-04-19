import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartTile extends StatelessWidget {
  final String title;
  final String id;
  final double quantity;
  final double price;

  CartTile({
    this.title,
    this.id,
    this.quantity,
    this.price,
  });

  String get realPrice {
    return (quantity * price).toString();
  }

  @override
  Widget build(BuildContext context) {
    CartItem cart = Provider.of<CartItem>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (_) => cart.deleteById(id),
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text(
                    'Are you sure want to delete this item?',
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('No'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () => Navigator.of(context).pop(true),
                    )
                  ],
                ));
      },
      direction: DismissDirection.endToStart,
      background: Container(
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        title: Text(title),
        subtitle: Text('The total is \$$realPrice'),
        trailing: Chip(
          label: Text('X ${quantity.round().toString()}'),
        ),
        leading: Chip(
          label: Text(price.toString()),
        ),
      ),
    );
  }
}
