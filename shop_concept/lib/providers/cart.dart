import 'package:flutter/material.dart';

class Cart {
  final String id;
  final String title;
  final double price;
  final double quantity;

  Cart({
    this.id,
    this.title,
    this.price,
    this.quantity,
  });
}

class CartItem with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  void addCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (current) => Cart(
          id: productId,
          price: current.price,
          title: current.title,
          quantity: current.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => Cart(
          id: DateTime.now().toString(),
          price: price,
          quantity: 1,
          title: title,
        ),
      );
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    double total = 0;
    _items.forEach((productId, cart) {
      total = total + cart.price * cart.quantity;
    });
    return total;
  }

  void deleteById(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void undoProcess(String id) {
    if (!_items.containsKey(id)) {
      return;
    }

    if (_items[id].quantity > 1) {
      _items.update(
          id,
          (item) => Cart(
              id: item.id,
              price: item.price,
              quantity: item.quantity - 1,
              title: item.title));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }
}
