import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class ItemList extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTx;

  ItemList(this.transaction, this.deleteTx);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  Color _bgColor;

  @override
  void initState() {
    const color = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple
    ];
    _bgColor = color[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _bgColor,
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text('\$${widget.transaction.amount}'),
                ),
              ),
            ),
            title: Text(
              widget.transaction.item,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(widget.transaction.date),
            ),
            trailing: MediaQuery.of(context).size.width > 460
                ? FlatButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                    textColor: Theme.of(context).errorColor,
                    onPressed: () => widget.deleteTx(widget.transaction.id),
                  )
                : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => widget.deleteTx(widget.transaction.id),
                  )));
  }
}
