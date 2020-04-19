import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../screens/add_product.dart';

class ManageProductTile extends StatefulWidget {
  final String id;
  final String title;
  final String imgUrl;

  ManageProductTile(this.id, this.title, this.imgUrl);

  @override
  _ManageProductTileState createState() => _ManageProductTileState();
}

class _ManageProductTileState extends State<ManageProductTile> {
  bool onProgress = false;

  void deleteItem(scaffold) {
    setState(() {
      onProgress = true;
    });

    Provider.of<Products>(context, listen: false)
        .deleteProductById(widget.id)
        .then((_) {
      scaffold.showSnackBar(SnackBar(
        content: Text('Successfully Deleted'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(widget.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imgUrl),
      ),
      trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                onPressed: () => Navigator.of(context)
                    .pushNamed(AddProduct.routeName, arguments: widget.id),
              ),
              onProgress
                  ? CircularProgressIndicator()
                  : IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => deleteItem(scaffold),
                    )
            ],
          )),
    );
  }
}
