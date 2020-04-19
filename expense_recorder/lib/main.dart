import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './widgets/chart.dart';
import './widgets/userTransactions.dart';
import './widgets/itemInput.dart';
import './models/transaction.dart';

void main() {
  runApp(new MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  //   runApp(new MyApp());
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Second App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
              ),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addObserver(this);
  //   super.initState();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print(state)
  //   super.didChangeAppLifecycleState(state);
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  // @override
  // void didUpdateWidget(MyHomePage oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  final List<Transaction> transactions = [];
  bool _currentState = false;

  List<Transaction> get _getRecent {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String itemTx, String amountTx, DateTime date) {
    if (amountTx == '') {
      return;
    }
    if (itemTx == '' || double.parse(amountTx) < 0 || date == null) {
      return;
    }

    setState(() {
      transactions.add(Transaction(
          date: date,
          id: DateTime.now().toString(),
          amount: double.parse(amountTx),
          item: itemTx));
    });

    Navigator.of(context).pop();
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            child: ItemInput(_addTransaction),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          );
        });
  }

  void deleteTx(String id) {
    setState(() {
      transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Widget> _buildLandscapeMode(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget list,
  ) {
    return [
      Container(
        // Switch
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Show Chart'),
            Switch.adaptive(
              value: _currentState,
              onChanged: (val) {
                setState(() {
                  _currentState = val;
                });
              },
            )
          ],
        ),
      ),
      _currentState
          ? Container(
              // Chart
              width: double.infinity,
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height) *
                  0.7,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Chart(_getRecent),
            )
          : list
    ];
  }

  List<Widget> _buildPortraitMode(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget list,
  ) {
    return [
      Container(
        // Chart
        width: double.infinity,
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            0.25,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Chart(_getRecent),
      ),
      list
    ];
  }

  Widget adaptiveCustomButton() {
    return Platform.isIOS
        ? Container()
        : FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _startAddTransaction(context);
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Expense Planner'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddTransaction(context);
          },
        )
      ],
      textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold)),
    );

    final list = Container(
      // List
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appBar.preferredSize.height) *
          0.7,
      child: UserTransactions(
        transactions,
        deleteTx,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          if (!isLandscape) ..._buildPortraitMode(mediaQuery, appBar, list),
          if (isLandscape) ..._buildLandscapeMode(mediaQuery, appBar, list),
        ],
      ),
      floatingActionButton: adaptiveCustomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
