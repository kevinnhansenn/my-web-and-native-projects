import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemInput extends StatefulWidget {
  final Function addTransaction;

  ItemInput(this.addTransaction);

  @override
  _ItemInputState createState() => _ItemInputState();
}

class _ItemInputState extends State<ItemInput> {
  final itemController = TextEditingController();
  final priceController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    widget.addTransaction(
        itemController.text, priceController.text, _selectedDate);
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((data) {
      if (data == null) {
        return;
      }
      setState(() {
        _selectedDate = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: itemController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  labelStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? ('No date chosen')
                          : ('Picked date: ' +
                              DateFormat.yMd().format(_selectedDate))),
                    ),
                    FlatButton(
                      child: Text('Choose Date'),
                      onPressed: _selectDate,
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                child: Text('Purchase'),
                textColor: Colors.white,
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
