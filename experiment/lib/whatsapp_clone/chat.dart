import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, String>> items = [
    {
      'id': '1',
      'name': 'Emma Olivia',
      'img': 'asset/photos/person1.jpg',
      'chat': 'How are you?',
      'date': 'Yesterday',
    },
    {
      'id': '2',
      'name': 'James Logan',
      'img': 'asset/photos/person2.jpg',
      'chat':
          'This is a dummy chat. It is a very long sentences to test the multiline on the ListTile',
      'date': 'Sunday',
    },
    {
      'id': '3',
      'name': 'Sophia Charlotte',
      'img': 'asset/photos/person3.jpg',
      'chat': 'This is a very very long long long text hahahahhaha',
      'date': 'Saturday',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 366,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: ((ctx, index) {
          return Dismissible(
            key: ValueKey(items[index]['id']),
            background: Container(
              color: Colors.red,
            ),
            secondaryBackground: Container(
              color: Colors.purple,
            ),
            child: Container(
              height: 75,
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(18, 0, 0, 0),
                title: Text(
                  items[index]['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                subtitle: Text(
                  items[index]['chat'],
                  maxLines: 2,
                ),
                trailing: Container(
                  padding: EdgeInsets.only(right: 13),
                  child: Text(
                    items[index]['date'],
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                leading: InkWell(
                  onTap: () async {
                    return await showDialog(
                        context: context,
                        builder: (_) => Dialog(
                              elevation: 8,
                              insetAnimationCurve: Curves.bounceIn,
                              insetAnimationDuration:
                                  Duration(milliseconds: 500),
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  items[index]['img'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ));
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(items[index]['img']),
                    radius: 30,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
