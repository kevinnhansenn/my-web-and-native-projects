import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './chartBar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTrans;

  Chart(this.recentTrans);

  List<Map<String, Object>> get generateRow {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double total = 0;
      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekDay.day &&
            recentTrans[i].date.month == weekDay.month &&
            recentTrans[i].date.year == weekDay.year) {
          total += recentTrans[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': total,
      };
    }).reversed.toList();
  }

  double get getSpendingAmount {
    return generateRow.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
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
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...generateRow.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data['day'],
                  spendingAmount: data['amount'],
                  spendingPercent: getSpendingAmount == 0.0
                      ? 0.0
                      : (data['amount'] as double) / getSpendingAmount,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
