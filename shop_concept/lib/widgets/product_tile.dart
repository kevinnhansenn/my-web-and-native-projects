import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductTile extends StatelessWidget {
  void selected(BuildContext ctx, String data) {
    Navigator.of(ctx).pushNamed(
      ProductDetail.routeName,
      arguments: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    CartItem cart = Provider.of<CartItem>(context, listen: false);
    Product example = Provider.of<Product>(context);
    return GestureDetector(
      onTap: () {
        selected(context, example.id);
      },
      child: GridTile(
        child: Image.network(
          example.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          title: Text(
            example.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (ctx, product, child) => GestureDetector(
              onTap: example.toggle,
              child: example.getStatus
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
            ),
          ),
          backgroundColor: Color.fromRGBO(101, 67, 33, 0.6),
          trailing: GestureDetector(
            onTap: () {
              cart.addCart(example.id, example.title, example.price);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Item has been added to shopping cart'),
                action: SnackBarAction(
                    label: 'UNDO',
                    textColor: Colors.white,
                    onPressed: () => cart.undoProcess(example.id)),
              ));
            },
            child: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
