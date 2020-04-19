import 'package:flutter/material.dart';

class ListController extends StatefulWidget {
  static const routeName = '/list-controller';
  @override
  _ListControllerState createState() => _ListControllerState();
}

class _ListControllerState extends State<ListController> {
  String message = '';
  String status = '';
  final itemSize = 100.0;
  ScrollController _controller;
  double containerHeight = 150.0;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(scrollController);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void scrollController() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = 'Reach Bottom';
      });
    } else if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = 'Reach Top';
      });
    } else {
      setState(() {
        message = 'In the middle';
      });
    }
  }

  void down() {
    _controller.animateTo(_controller.offset + itemSize,
        duration: Duration(milliseconds: 600), curve: Curves.linear);
  }

  void up() {
    _controller.animateTo(_controller.offset - itemSize,
        duration: Duration(milliseconds: 600), curve: Curves.linear);
  }

  void _onStart(ScrollMetrics met) {
    setState(() {
      status = 'Scroll Start';
    });
  }

  void _onUpdate(ScrollMetrics met) {
    setState(() {
      status = 'Scroll Update';
    });

    if (_controller.offset > 2 * itemSize) {
      setState(() {
        containerHeight = 0.0;
      });
    } else if (_controller.offset < 2 * itemSize) {
      setState(() {
        containerHeight = 150.0;
      });
    }
  }

  void _onEnd(ScrollMetrics met) {
    setState(() {
      status = 'Scroll End';
    });
  }

  void toTop() {
    _controller.animateTo(
      0,
      duration: Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Controller'),
        actions: <Widget>[
          FlatButton(
            child: Text('Top'),
            onPressed: toTop,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.purple[200],
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: Text('Down'),
                  onPressed: down,
                ),
                Text(message),
                Text(status),
                FlatButton(
                  child: Text('Up'),
                  onPressed: up,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            height: containerHeight,
            color: Colors.orange[200],
            width: double.infinity,
            child: Center(child: Text('Sliver-like')),
          ),
          Expanded(
            child: NotificationListener(
              onNotification: ((notif) {
                if (notif is ScrollStartNotification) {
                  _onStart(notif.metrics);
                } else if (notif is ScrollUpdateNotification) {
                  _onUpdate(notif.metrics);
                } else if (notif is ScrollEndNotification) {
                  _onEnd(notif.metrics);
                }
                return true;
              }),
              child: ListView.builder(
                controller: _controller,
                itemExtent: itemSize,
                itemBuilder: ((ctx, index) {
                  return ListTile(
                    title: Text('Data $index'),
                  );
                }),
                itemCount: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
