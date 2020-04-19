import 'package:flutter/material.dart';
import './itemList.dart';
import '../models/transaction.dart';

class UserTransactions extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  UserTransactions(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, cons) {
              return Column(
                children: <Widget>[
                  Container(
                    height: cons.maxHeight * 0.1,
                    child: Text(
                      'There is no transaction to show',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  SizedBox(
                    height: cons.maxHeight * 0.05,
                  ),
                  Container(
                    height: cons.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )

        // NEED TO SET TO STATEFUL AND KEY SUPER KEY ASSIGNMENT
        // : ListView(
        //     children: <Widget>[
        //       ...transactions.map((tx) {
        //         return Container(
        //           width: double.infinity,
        //           height: 100,
        //           padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
        //           child: ItemList(
        //               key: ValueKey(tx.id),
        //               transaction: tx,
        //               deleteTx: deleteTx),
        //         );
        //       })
        //     ],
        //   );

        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Container(
                width: double.infinity,
                height: 100,
                padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                child: ItemList(transactions[index], deleteTx),
              );
            },
          );
  }
}
