import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/order_overview.dart';
import '../widgets/order_overview.dart';
import '../providers/order.dart';
import '../widgets/side_drawer.dart';

class OrderPage extends StatelessWidget {
  static const routeName = '/order-page';

  @override
  Widget build(BuildContext context) {
    OrderItem order = Provider.of<OrderItem>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      drawer: SideDrawer(),
      body: ListView.builder(
          itemCount: order.orders.length,
          itemBuilder: (ctx, index) {
            return OrderOverview(order.orders[index]);
          }),
    );
  }
}
