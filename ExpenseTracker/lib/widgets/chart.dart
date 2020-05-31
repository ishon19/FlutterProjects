import 'package:ExpenseTracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final dayOfWeek = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (dayOfWeek.day == recentTransactions[i].date.day &&
            dayOfWeek.month == recentTransactions[i].date.month &&
            dayOfWeek.year == recentTransactions[i].date.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(dayOfWeek),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data) {
          return Text(" ${data['day']} : ${data['amount']}");
        }).toList(),
      ),
    );
  }
}
