import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Product getProductById(String id) {
    return _items.where((item) => item.id == id).toList()[0];
  }

  List<Product> get getFavorite {
    return _items.where((item) => item.isFavorite).toList();
  }

  bool checkExistanceById(String id) {
    bool found = false;
    _items.forEach((item) {
      if (item.id == id) {
        found = true;
      }
    });
    return found;
  }

  Future<void> updateProduct(Product prod) async {
    final url = 'https://myproject-196d9.firebaseio.com/alpha/${prod.id}.json';

    final response = await http.patch(
      url,
      body: json.encode({
        'title': prod.title,
        'description': prod.description,
        'price': prod.price,
        'imageUrl': prod.imageUrl
      }),
    );

    if (response.statusCode >= 400) {
      throw HttpException('Failed');
    }

    int index = _items.indexWhere((item) => item.id == prod.id);
    _items[index] = prod;

    notifyListeners();
  }

  Future<void> addProduct(Product prod) async {
    const String url = 'https://myproject-196d9.firebaseio.com/alpha.json';
    try {
      final res = await http.post(url,
          body: json.encode(
            {
              'title': prod.title,
              'description': prod.description,
              'price': prod.price,
              'imageUrl': prod.imageUrl
            },
          ));
      if (res.statusCode >= 400) {
        throw HttpException('Error');
      }
      _items.add(prod);
      notifyListeners();
    } catch (err) {
      throw (err);
    } finally {
      print('Finally executed');
    }
  }

  Future<void> deleteProductById(String id) async {
    final url = 'https://myproject-196d9.firebaseio.com/alpha/$id.json';
    try {
      await http.delete(url);
    } catch (err) {
      throw HttpException(err);
    }

    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> fetchProduct() async {
    const url = 'https://myproject-196d9.firebaseio.com/alpha.json';
    try {
      final fetchedData = await http.get(url);
      Map<String, dynamic> data = json.decode(fetchedData.body);
      List<Product> allProduct = [];

      data.forEach((prodId, prodData) {
        allProduct.add(Product(
          id: prodId,
          title: prodData['title'],
          price: prodData['price'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
        ));
      });

      _items = allProduct;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }
}
