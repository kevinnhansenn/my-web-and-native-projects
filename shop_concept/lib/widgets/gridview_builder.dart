import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/product_tile.dart';

class GridViewBuilder extends StatelessWidget {
  final _showOnlyFavs;

  GridViewBuilder(this._showOnlyFavs);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Products>(context, listen: false).fetchProduct(),
      builder: (ctx, data) {
        if (data.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (data.error != null) {
            return Center(
              child: Text('Something went wrong!'),
            );
          } else {
            return Consumer<Products>(
              builder: (ctx, prods, child) {
                List<Product> products =
                    _showOnlyFavs ? prods.getFavorite : prods.items;
                return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                    value: products[index],
                    child: ProductTile(),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}
