import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart';
import '../providers/cart.dart';
import "package:charcode/charcode.dart";

class OrderOverview extends StatefulWidget {
  final Order order;

  OrderOverview(this.order);

  @override
  _OrderOverviewState createState() => _OrderOverviewState();
}

class _OrderOverviewState extends State<OrderOverview> {
  bool isDetail = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Total \$${widget.order.total}'),
          subtitle:
              Text('Date: ${DateFormat.yMEd().format(widget.order.date)}'),
          trailing: GestureDetector(
            child: Icon(Icons.expand_more),
            onTap: () {
              setState(() {
                isDetail = !isDetail;
              });
            },
          ),
        ),
        !isDetail
            ? Container()
            : Container(
                height: 100,
                child: Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        Cart temp =
                            widget.order.products.values.toList()[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Item: ${temp.title} ${String.fromCharCode($tab)} \$${temp.price} X ${temp.quantity.toStringAsFixed(0)} ${String.fromCharCode($tab)} = ${(temp.price * temp.quantity).toString()}',
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      },
                      itemCount: widget.order.products.length,
                    ),
                  ),
                ),
              ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
