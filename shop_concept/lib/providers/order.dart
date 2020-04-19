import 'package:flutter/foundation.dart';
import '../providers/cart.dart';

class Order {
  String id;
  @required
  double total;
  DateTime date;
  @required
  Map<String, Cart> products;

  Order({this.id, this.total, this.date, this.products});
}

class OrderItem with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(double total, Map<String, Cart> products) {
    _orders.insert(
      0,
      Order(
        date: DateTime.now(),
        id: DateTime.now().toString(),
        products: products,
        total: total,
      ),
    );
    notifyListeners();
  }
}
