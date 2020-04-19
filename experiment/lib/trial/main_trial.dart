import 'package:flutter/material.dart';

class MainTrial extends StatefulWidget {
  static const routeName = '/trial';
  @override
  _MainTrialState createState() => _MainTrialState();
}

class _MainTrialState extends State<MainTrial> {
  int numRun = 0;
  Widget shape;
  ValueNotifier _valueNotifier = ValueNotifier<int>(0);

  void pressedA() {
    setState(() {
      shape = Container(
        key: ValueKey(1),
        height: 100,
        width: 100,
        decoration: ShapeDecoration(
          shape: CircleBorder(),
          color: Colors.green,
        ),
      );
    });
  }

  void pressedB() {
    setState(() {
      shape = Container(
        key: ValueKey(2),
        height: 100,
        width: 100,
        color: Colors.purple,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    numRun += 1;
    print('Number of run : ${numRun.toString()}');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: ((child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    )),
                child: shape,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: pressedA,
                  color: Colors.purple,
                  child: const Text('Button A'),
                ),
                OutlineButton(
                  onPressed: pressedB,
                  color: Colors.green,
                  child: Text('Button B'),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ValueListenableBuilder(
                  valueListenable: _valueNotifier,
                  builder: ((_, value, __) => TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 600),
                        tween: IntTween(begin: value - 50, end: value),
                        curve: Curves.linear,
                        builder: ((_, value, __) => Text(value.toString())),
                      )),
                ),
                FlatButton(
                  onPressed: () => _valueNotifier.value += 50,
                  child: Text('Increment'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
