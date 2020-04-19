import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import './add_product.dart';
import '../widgets/side_drawer.dart';
import '../widgets/manage_product_tile.dart';

class ManageProduct extends StatelessWidget {
  static const routeName = '/manage-product';

  Future<void> refresh(BuildContext ctx) async {
    await Provider.of<Products>(ctx).fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddProduct.routeName),
          )
        ],
      ),
      drawer: SideDrawer(),
      body: Consumer<Products>(
          builder: (ctx, prods, child) => RefreshIndicator(
                onRefresh: () => refresh(context),
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    prods.fetchProduct();
                    return ManageProductTile(prods.items[index].id,
                        prods.items[index].title, prods.items[index].imageUrl);
                  },
                  itemCount: prods.items.length,
                ),
              )),
    );
  }
}
