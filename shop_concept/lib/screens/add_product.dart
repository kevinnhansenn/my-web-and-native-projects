import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';

class AddProduct extends StatefulWidget {
  static const routeName = '/add-product';
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _key = GlobalKey<FormState>();
  bool _loading = false;
  bool _run = true;

  Product initial = Product(
    id: null,
    description: '',
    price: 0,
    imageUrl: '',
    title: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_run) {
      String id = ModalRoute.of(context).settings.arguments as String;
      if (id == null) {
        return;
      }
      Products products = Provider.of<Products>(context, listen: false);
      Product prod = products.getProductById(id);
      initial = prod;
      _imageUrlController.text = prod.imageUrl;
    }
    _run = false;
    super.didChangeDependencies();
  }

  void _updateImage() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _submitForm() {
    _key.currentState.validate();
    _key.currentState.save();
    Products products = Provider.of<Products>(context, listen: false);

    setState(() {
      _loading = true;
    });

    products.checkExistanceById(initial.id)
        ? products.updateProduct(initial).then((_) {
            setState(() {
              _loading = false;
            });
            Navigator.of(context).pop();
          }).catchError((err) {
            setState(() {
              _loading = false;
            });
            Navigator.of(context).pop();
          })
        : products.addProduct(initial).then((_) {
            setState(() {
              _loading = false;
            });
            Navigator.of(context).pop();
          }).catchError((error) {
            return showDialog<Null>(
                context: context,
                builder: (ctx) => AlertDialog(
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Okay'),
                          onPressed: () {
                            setState(() {
                              _loading = false;
                            });
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ],
                      title: Text('Something is wrong!'),
                    ));
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () => _submitForm(),
          )
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _key,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  TextFormField(
                    initialValue: initial.title,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please input something';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      initial = Product(
                        id: initial.id,
                        description: initial.description,
                        price: initial.price,
                        imageUrl: initial.imageUrl,
                        title: value,
                      );
                    },
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFocusNode),
                  ),
                  TextFormField(
                      initialValue:
                          initial.price == 0 ? '' : initial.price.toString(),
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode),
                      validator: (value) {
                        if (double.tryParse(value) == null) {
                          return 'Please input a number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Invalid number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        initial = Product(
                          id: initial.id,
                          description: initial.description,
                          price: double.parse(value),
                          imageUrl: initial.imageUrl,
                          title: initial.title,
                        );
                      }),
                  TextFormField(
                      initialValue: initial.description,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.newline,
                      focusNode: _descriptionFocusNode,
                      maxLines: 3,
                      onFieldSubmitted: null,
                      onSaved: (value) {
                        initial = Product(
                          id: initial.id,
                          description: value,
                          price: initial.price,
                          imageUrl: initial.imageUrl,
                          title: initial.title,
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 130,
                          height: 130,
                          decoration:
                              BoxDecoration(border: Border.all(width: 2)),
                          child: _imageUrlController.text.isEmpty
                              ? Center(
                                  child: Text('Input a URL'),
                                )
                              : FittedBox(
                                  fit: BoxFit.cover,
                                  child:
                                      Image.network(_imageUrlController.text),
                                ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onSaved: (value) {
                                initial = Product(
                                  id: initial.id,
                                  description: initial.description,
                                  price: initial.price,
                                  imageUrl: value,
                                  title: initial.title,
                                );
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
