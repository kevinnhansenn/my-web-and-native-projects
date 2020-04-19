import 'package:flutter/material.dart';
import './db_helper.dart';

class MainPageSQL extends StatefulWidget {
  static const routeName = '/sql';
  @override
  _MainPageSQLState createState() => _MainPageSQLState();
}

List<Map<String, dynamic>> data = [
  {'name': 'Kevin', 'number': 13},
  {'name': 'Hansen', 'number': 20},
];

class _MainPageSQLState extends State<MainPageSQL> {
  final _formKey = GlobalKey<FormState>();
  void addData() {
    showDialog(
        context: context,
        builder: (_) {
          String submittedName;
          String submittedNumber;

          void processData() async {
            await DBHelper.insert(submittedName, submittedNumber);
            Navigator.of(context).pop();
            setState(() {});
          }

          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Enter name'),
                      onSaved: (name) => submittedName = name,
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Enter your number'),
                      onSaved: (number) => submittedNumber = number,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: OutlineButton(
                        child: Text('ADD'),
                        onPressed: () {
                          _formKey.currentState.save();
                          processData();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  final _editFormKey = GlobalKey<FormState>();
  void editDialog(String name) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Form(
              key: _editFormKey,
              child: Container(
                height: 130,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Enter the number'),
                      onSaved: (number) async {
                        await DBHelper.edit(name, number);
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: OutlineButton(
                        child: Text('EDIT'),
                        onPressed: () {
                          _editFormKey.currentState.save();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> fetchAndUpdate() async {
    data = await DBHelper.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD SQL'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: addData,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchAndUpdate(),
        builder: (_, snap) => snap.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) => Dismissible(
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => DBHelper.delete(data[index]['name']),
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                  key: ValueKey(data[index]['name']),
                  child: ListTile(
                    title: Text(data[index]['name']),
                    leading: Text(data[index]['number'].toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => editDialog(data[index]['name']),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
